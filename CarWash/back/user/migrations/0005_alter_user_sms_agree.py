# Generated by Django 4.2.4 on 2023-08-17 07:01

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0004_alter_user_address_detail'),
    ]

    operations = [
        migrations.AlterField(
            model_name='user',
            name='sms_agree',
            field=models.BooleanField(default=True),
        ),
    ]
