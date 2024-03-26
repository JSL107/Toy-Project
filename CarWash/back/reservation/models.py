from django.db import models
from user.models import User


# Create your models here.

class Reservation(models.Model):
    id = models.BigAutoField(primary_key=True)
    reservation_people = models.ForeignKey(User, on_delete=models.CASCADE)
    reservation_date = models.DateTimeField()
    car_type = models.TextField()
    price = models.IntegerField()  # 후에 예약 상품의 금액으로 변경
    reservation_memo = models.TextField()
