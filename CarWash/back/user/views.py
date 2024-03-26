import bcrypt
from rest_framework.decorators import api_view, action, permission_classes
from rest_framework.views import APIView
from .UserSerializer import UserSerializer
from .models import User
from rest_framework.response import Response
from .tokens import generate_token
from django.core.mail import send_mail
from django.core.cache import cache
from django.core.exceptions import ObjectDoesNotExist
from django.template.loader import render_to_string
from django.utils.html import strip_tags
import random
import string


def generate_verification_code(length=8):
    characters = string.ascii_letters + string.digits

    # 모든 문자가 포함되도록 순서를 섞음
    shuffled_characters = random.sample(characters, len(characters))

    # 길이만큼 문자를 선택해서 인증 코드 생성
    verification_code = ''.join(random.choice(shuffled_characters) for _ in range(length))
    return verification_code


@api_view(['POST'])
def handle_email_code(request):
    emails = request.data.get('emails')
    try:
        user = User.objects.get(email=emails)
        return Response({"error": "이미 인증된 메일 입니다."})
    except User.DoesNotExist:
        verification_code = generate_verification_code()
        print(verification_code)
        store_verification_code(request, emails, verification_code)
        send_verification_email(emails, verification_code, 1)
        return Response({"message": "이메일이 성공적으로 전송되었습니다."})
    except Exception as e:
        return Response({"error": "이메일 전송 중 오류가 발생했습니다.", "details": str(e)})


def store_verification_code(request, user_id, verification_code):
    cache_key = f"verification_code_{user_id}"
    cache.set(cache_key, verification_code, timeout=300)  # 5분 동안 유효한 인증번호 저장
    request.session['verification_code_user_id'] = user_id


@api_view(['POST'])
def handle_name_phone_number_submit(request):
    name = request.data.get('name')
    phone_number = request.data.get('phone_number')
    try:
        user = User.objects.get(name=name, phone_number=phone_number)

        verification_code = generate_verification_code()
        store_verification_code(request, user.id, verification_code)
        send_verification_email(user.email, verification_code, 0)

        return Response({"message": "이메일이 성공적으로 전송되었습니다."})
    except ObjectDoesNotExist:
        data = {
            "results": {
                "msg": "유저 정보가 올바르지 않습니다.",
                "code": "E4010"
            }
        }
        return Response(data=data)


def send_verification_email(to_email, verification_code, type_number):
    subject = '안녕하세요 세차예약 어플입니다.'
    from_email = 'testdd258456@gmail.com'  # 발신 이메일 주소
    recipient_list = [to_email]  # 수신자 이메일 주소 목록

    if type_number == 0:
        # HTML 템플릿 렌더링
        html_message = render_to_string('verification_email_template.html', {'verification_code': verification_code})
        # HTML 태그 제거한 텍스트 메시지 생성

    else:
        html_message = render_to_string('signup_email_template.html', {'verification_code': verification_code})

    plain_message = strip_tags(html_message)
    send_mail(subject, plain_message, from_email, recipient_list, html_message=html_message)


@api_view(['POST'])
def verify_verification_code(request):
    entered_code = request.data.get('entered_code')
    user_id = request.session.get('verification_code_user_id')
    if user_id:
        cache_key = f"verification_code_{user_id}"
        saved_code = cache.get(cache_key)
        if saved_code == entered_code:
            return Response({"result": "True"})
        else:
            return Response({"result": "False"})


@action(methods=['POST'], detail=False)
class LoginView(APIView):
    @staticmethod
    def post(request):
        user_id = request.data.get('user_id')
        password = request.data.get('password').encode("utf-8")
        try:
            user = User.objects.get(id=user_id)
            payload_value = user_id

            payload = {
                "subject": payload_value,
            }
            if bcrypt.checkpw(password, user.pw.encode('utf-8')):
                from back.settings import SECRET_KEY

                token = generate_token(payload, "access")

                print(token)
                data = {
                    "results": {
                        "access_token": token
                    }
                }
                return Response(data=data)

            else:
                return Response(data={'error': '로그인 정보가 올바르지 않습니다.'})
        except User.DoesNotExist:
            data = {
                "results": {
                    "msg": "유저 정보가 올바르지 않습니다.",
                    "code": "E4010"
                }
            }
            return Response(data=data)

        except Exception as e:
            print(e)
            data = {
                "results": {
                    "msg": "정상적인 접근이 아닙니다.",
                    "code": "E5000"
                }
            }
            return Response(data=data)


@api_view(['POST'])
def create_user(request):
    serializer = UserSerializer(data=request.data)

    if serializer.is_valid():
        user = serializer.save()
        return Response({"message": "사용자가 성공적으로 생성되었습니다."})
    else:
        return Response(serializer.errors)


@api_view(['POST'])
def user_api(request):
    serializer = UserSerializer(data=request.data)
    if serializer.is_valid():
        try:
            serializer.save()
            return Response(serializer.data)
        except Exception as e:
            return Response({"error_message": str(e)})
    return Response(serializer.errors)


@api_view(['POST'])
def change_password_view(request):
    user_id = request.session.get('verification_code_user_id')
    new_password = request.data.get('newPassword')

    try:
        user = User.objects.get(id=user_id)
        UserSerializer.update(self=user, instance=user, validated_data={'new_password': new_password})
        return Response({"message": "비밀번호가 성공적으로 변경되었습니다."})

    except User.DoesNotExist:
        return Response({"message": "해당 사용자를 찾을 수 없습니다."})
