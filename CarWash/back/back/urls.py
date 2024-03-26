from django.contrib import admin
from django.urls import path, include
from django.views.decorators.csrf import csrf_exempt

from user.views import user_api, LoginView, handle_name_phone_number_submit, verify_verification_code, \
    change_password_view, handle_email_code
from board.views import select_board_list, board_info, board_detail

urlpatterns = [
    path('admin/', admin.site.urls),
    path('join', user_api, name='user_api'),
    path('login/', LoginView.as_view(), name='login'),
    path('board_list/', select_board_list, name='select_board_list'),
    path('board_info/', board_info, name='board_info'),
    path('board_detail/<int:board_id>', board_detail, name='board_detail'),
    path('send-verification-code/', handle_name_phone_number_submit,
         name='handle_name_phone_number_submit'),
    path('verify_verification_code/', verify_verification_code, name='verify_verification_code'),
    path('change-password/', change_password_view, name='change_password'),
    path('handle_email_code/', handle_email_code, name='handle_email_code'),
]
