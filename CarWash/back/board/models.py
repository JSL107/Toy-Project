from django.db import models

from user.models import User


# Create your models here.
class Board(models.Model):
    author = models.ForeignKey(User, on_delete=models.CASCADE)
    title = models.TextField(null=False)
    context = models.TextField()
    write_date = models.DateTimeField(auto_now_add=True)
    modify_date = models.DateTimeField(auto_now=True)
    image = models.ImageField(null=True, upload_to="",
                              default='https://3.bp.blogspot.com/-ZKBbW7TmQD4/U6P_DTbE2MI/AAAAAAAADjg/wdhBRyLv5e8'
                                      '/s1600/noimg.gif')
    category = models.TextField(null=False)
