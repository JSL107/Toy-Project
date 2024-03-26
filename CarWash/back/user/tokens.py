import datetime
from back.settings import SECRET_KEY
import jwt


def generate_token(payload, type):
    if type == "access":
        # 2시간
        exp = datetime.datetime.utcnow() + datetime.timedelta(hours=2)
    elif type == "refresh":
        # 2주
        exp = datetime.datetime.utcnow() + datetime.timedelta(weeks=2)
    else:
        raise Exception("Invalid tokenType")

    payload['exp'] = exp
    payload['iat'] = datetime.datetime.utcnow()
    encoded = jwt.encode(payload, SECRET_KEY, algorithm='HS256')

    return encoded
