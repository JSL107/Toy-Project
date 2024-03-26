from django.db import models


class User(models.Model):
    id = models.TextField(null=False, primary_key=True)  # ID
    pw = models.TextField(null=False)  # PW
    email = models.TextField(null=False, unique=True)  # 이메일
    phone_number = models.TextField(null=False, unique=True)  # 휴대폰 번호
    create_date = models.DateTimeField(auto_now_add=True)  # 계정 생성일 (auto_now_add : 최초 생성 시만 저장)
    last_login = models.DateTimeField(auto_now=True)  # 마지막 로그인 날짜 (auto_now : 자동으로 업데이트)
    use_YN = models.BooleanField(default=True)  # 계정 활성 여부
    address = models.TextField()  # 주소
    sms_agree = models.BooleanField(default=False)  # SMS 수신 동의
    address_detail = models.TextField(default='')  # 상세 주소
    name = models.TextField(default='')


class UserAuth(models.Model):
    user = models.OneToOneField("User", on_delete=models.CASCADE)
    auth = models.CharField(null=False, default='USER')  # 유저 권한


class UserPoint(models.Model):
    user = models.OneToOneField("User", on_delete=models.CASCADE)
    point = models.IntegerField(default=0)  # 포인트


class UserGrade(models.Model):
    user = models.OneToOneField("User", on_delete=models.CASCADE)
    grade = models.IntegerField(default=0)  # 등급


def __str__(self):
    return self.caption
