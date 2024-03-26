import bcrypt
from rest_framework import serializers
from .models import User, UserAuth, UserGrade, UserPoint


class UserSerializer(serializers.ModelSerializer):
    pw2 = serializers.CharField(write_only=True, required=True)
    new_password = serializers.CharField(write_only=True, required=False)

    class Meta:
        model = User
        fields = (
            'id', 'pw', 'name', 'email', 'phone_number', 'create_date', 'last_login',
            'use_YN', 'address', 'sms_agree', 'pw2', 'address_detail', 'new_password'
        )
        read_only_fields = ('create_date', 'last_login', 'use_YN')

    def validate(self, attrs):
        if attrs['pw'] != attrs['pw2']:
            raise serializers.ValidationError(
                {"error_message": "비밀번호가 일치하지 않습니다."})

        if User.objects.filter(id=attrs['id']).exists():
            raise serializers.ValidationError(
                {"error_message": "이미 사용중인 아이디입니다."})

        if User.objects.filter(phone_number=attrs['phone_number']).exists():
            raise serializers.ValidationError(
                {"error_message": "이미 등록되어있는 휴대폰 번호입니다."})

        if User.objects.filter(email=attrs['email']).exists():
            raise serializers.ValidationError(
                {"error_message": "이미 사용중인 이메일입니다."})

        return attrs

    def create(self, validated_data):

        user = User.objects.create(
            id=validated_data['id'],
            # 비밀번호 암호화 (bcrypt 형태)
            pw=bcrypt.hashpw(validated_data['pw'].encode("utf-8"), bcrypt.gensalt()).decode("utf-8"),
            name=validated_data['name'],
            email=validated_data['email'],
            phone_number=validated_data['phone_number'],
            address=validated_data['address'],
            sms_agree=validated_data['sms_agree'],
            address_detail=validated_data['address_detail']
        )

        user_auth = UserAuth.objects.create(
            auth='USER',
            user_id=validated_data['id'],
        )

        user_grade = UserGrade.objects.create(
            grade=0,
            user_id=validated_data['id'],
        )

        user_point = UserPoint.objects.create(
            point=0,
            user_id=validated_data['id'],
        )

        user_auth.save()
        user.save()
        user_grade.save()
        user_point.save()

        return user

    def update(self, instance, validated_data):
        new_password = validated_data.get('new_password')
        instance.pw = bcrypt.hashpw(new_password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
        instance.save()
        return instance
