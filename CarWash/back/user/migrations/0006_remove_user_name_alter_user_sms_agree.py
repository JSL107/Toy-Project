# Generated by Django 4.2.4 on 2023-08-21 01:29

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('user', '0005_alter_user_sms_agree'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='user',
            name='name',
        ),
        migrations.AlterField(
            model_name='user',
            name='sms_agree',
            field=models.BooleanField(default=False),
        ),
    ]
