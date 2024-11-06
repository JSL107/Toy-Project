import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
import requests
from bs4 import BeautifulSoup
import time
from datetime import datetime
import os
import dotenv

dotenv.load_dotenv()

# 환경 변수에서 설정 가져오기
from_email = os.getenv("EMAIL_ADDRESS")
password = os.getenv("EMAIL_PASSWORD")
sender_name = os.getenv("SENDER_NAME")


# 이메일 전송 함수
def send_email(subject, body, to_email):
    msg = MIMEMultipart()
    msg["From"] = f"{sender_name} <{from_email}>"
    msg["To"] = to_email
    msg["Subject"] = subject
    msg.attach(MIMEText(body, "plain"))

    try:
        server = smtplib.SMTP_SSL("smtp.gmail.com", 465)
        server.login(from_email, password)
        text = msg.as_string()
        server.sendmail(from_email, to_email, text)
        print(f"[{datetime.now()}] 이메일 전송 성공: {to_email}")
        server.quit()
    except Exception as e:
        print(f"[{datetime.now()}] 이메일 전송 실패:", e)


# 환율 모니터링
def monitor_exchange_rate(user_targets):
    last_values = {email: None for email in user_targets.keys()}

    try:
        while True:
            url = "https://search.naver.com/search.naver?sm=mtb_drt&where=m&query=%EC%9D%BC%EB%B3%B8%ED%99%98%EC%9C%A8"
            response = requests.get(url)
            soup = BeautifulSoup(response.text, "html.parser")

            value_element = soup.select_one("div.price_info > strong.price")

            if value_element:
                current_value = float(value_element.text.strip().replace(",", ""))
                if all(
                        current_value == last_values[email] for email in user_targets.keys()
                ):
                    print(f"[{datetime.now()}]")
                else:
                    print(f"[{datetime.now()}] {current_value}원")

                for email, (target_value, alert_percentage) in user_targets.items():
                    user_name = email.split("@")[0]

                    if last_values[email] is not None:
                        if alert_percentage > 0:
                            change_percentage = (
                                                        (current_value - last_values[email])
                                                        / last_values[email]
                                                ) * 100
                            if abs(change_percentage) >= alert_percentage:
                                send_email(
                                    "환율 변동 알림",
                                    f"{user_name}님,\n\n현재 환율이 {change_percentage:.2f}% 변동되었습니다.\n\n현재 환율: {current_value}원\n",
                                    email,
                                )
                                print(
                                    f"[{datetime.now()}] {user_name}님에게 환율 변동 알림을 보냈습니다."
                                )

                    if current_value <= target_value:
                        send_email(
                            "환율 목표 달성 알림",
                            f"{user_name}님,\n\n현재 엔화 환율이 설정 하신 금액 {target_value}원 이하로 떨어졌습니다.\n\n현재 환율: {current_value}원\n",
                            email,
                        )
                        print(
                            f"[{datetime.now()}] {user_name}님에게 목표 달성 알림을 보냈습니다."
                        )

                    last_values[email] = current_value

            else:
                print(f"[{datetime.now()}] 환율 정보를 가져오는 데 실패했습니다")

            time.sleep(10)

    except KeyboardInterrupt:
        print("모니터링 중지")


if __name__ == "__main__":
    user_targets = {}
    while True:
        email = input("이메일을 입력하세요 (종료하려면 'exit' 입력): ")
        if email.lower() == "exit":
            break
        target_value = float(input("목표 환율 금액을 입력하세요: "))
        alert_percentage = float(
            input("변동 비율 (%)을 입력하세요 (0 입력 시 비율 알림 비활성화): ")
        )
        user_targets[email] = (target_value, alert_percentage)

    monitor_exchange_rate(user_targets)
