import React, {useEffect, useRef, useState} from 'react';
import '../styles/user/signup.css';
import SWAL from 'sweetalert2'
import {useDaumPostcodePopup} from 'react-daum-postcode';
import axios from "axios";
import Loading from "../components/Loading";
import EmailVerificationModal from "../components/EmailConfirmModal";

interface FormData {
    id: string;
    email: string;
    pw: string;
    pw2: string;
    name: string;
    phone_number: string;
    address: string;
    sms_agree: boolean;
    address_detail: string;
    email_confirm: number;
}

declare global {
    interface Window {
        // @ts-ignore
        daum?: any;	// 지도 모듈
        IMP?: any;	// 결제 모듈
    }
}

function Signup() {
    const [formData, setFormData] = useState<FormData>({
        id: '',
        email: '',
        pw: '',
        pw2: '',
        name: '',
        phone_number: '',
        address: '',
        sms_agree: false,
        address_detail: '',
        email_confirm: 0,
    });

    const [isOpen, setIsOpen] = useState(false);
    const [isLoading, setLoading] = useState(false);
    const [isTimerActive, setIsTimerActive] = useState(false);
    const [timeLeft, setTimeLeft] = useState(300); // 초기 시간 설정 (초단위)
    const [emails, setEmails] = useState('');
    const [address, setAddress] = useState('');
    const [isEmailConfirm, setIsEmailConfirm] = useState(false)

    const idPattern = /^[a-zA-Z0-9_-]{4,16}$/;
    const pwPattern = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
    const emailPattern = /^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$/;
    const phonePattern = /^\d{10,11}$/;
    const open = useDaumPostcodePopup();


    function validateInput(key: keyof FormData, value: string): string | null {
        if (key === 'id' && !idPattern.test(value)) {
            return '아이디 형식이 올바르지 않습니다.';
        } else if (key === 'email' && !emailPattern.test(value)) {
            return '이메일 형식이 올바르지 않습니다.';
        } else if (key === 'pw' && !pwPattern.test(value)) {
            return '비밀번호 형식이 올바르지 않습니다.';
        } else if (key === 'phone_number' && !phonePattern.test(value)) {
            return '휴대폰 번호 형식이 올바르지 않습니다.';
        } else if ((key === 'name') && value.trim() === '') {
            return '이름은 필수 정보입니다.';
        } else if ((key === 'address') && value.trim() === '') {
            return '주소는 필수 정보입니다.';
        }
        // 다른 입력에 대한 유효성 검사 추가

        return null;
    }

    function validatePasswordMatch(): boolean {
        return formData.pw === formData.pw2;
    }

    useEffect(() => {
        if (isTimerActive && timeLeft > 0) {
            const timer = setTimeout(() => {
                setTimeLeft(timeLeft - 1);
            }, 1000);

            return () => {
                clearTimeout(timer);
            };
        } else if (timeLeft === 0) {
            setIsTimerActive(false); // 시간 종료 시 타이머 비활성화
        }
    }, [isTimerActive, timeLeft]);

    const handleSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();

        for (const key in formData) {
            const errorMessage = validateInput(key as keyof FormData, formData[key as keyof FormData] as string);
            if (errorMessage) {
                SWAL.fire('오류', errorMessage, 'warning');
                return;
            }
        }

        if (!validatePasswordMatch()) {
            SWAL.fire('오류', '비밀번호가 일치하지 않습니다.', 'warning');
            return;
        }

        try {
            const response = await fetch('http://localhost:8000/join', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData),
            });

            const responseData = await response.json();
            if (response.ok) {
                SWAL.fire('환영합니다!', '회원가입이 성공적으로 완료되었습니다.', 'success');
                setTimeout(() => {
                }, 1000)

            } else {
                for (let data in responseData) {
                    switch (data) {
                        case "id":
                            SWAL.fire('중복된 아이디', '중복된 아이디 입니다.', 'info')
                            break;
                        case "email":
                            SWAL.fire('중복된 이메일', '중복된 이메일 입니다.', 'info')
                            break;
                        case "phone_number":
                            SWAL.fire('중복된 휴대전화', '중복된 휴대폰 번호입니다.', 'info')
                            break;
                    }
                }
            }
        } catch (error) {
            SWAL.fire('서버 오류', '서버와의 통신 중 오류가 발생하였습니다.', 'error');
        }
    };

    const handleInputChange = (event: React.ChangeEvent<HTMLInputElement> | React.ChangeEvent<HTMLSelectElement>) => {
        const target = event.target;
        const name = target.name;
        if (name === 'email') {
            setEmails(target.value);
        }
        const value = target.type === 'checkbox' ? (target as HTMLInputElement).checked : target.value;
        setFormData({
            ...formData,
            [name]: value,
        });
    };


    const handleComplete = (data: { address: any; addressType: string; bname: string; buildingName: string; }) => {
        let fullAddress = data.address;
        let extraAddress = '';

        if (data.addressType === 'R') {
            if (data.bname !== '') {
                extraAddress += data.bname;
            }
            if (data.buildingName !== '') {
                extraAddress += extraAddress !== '' ? `, ${data.buildingName}` : data.buildingName;
            }
            fullAddress += extraAddress !== '' ? ` (${extraAddress})` : '';
        }
        setAddress(fullAddress);
    };

    const handleClick = () => {
        open(
            {
                onComplete: handleComplete,
                popupTitle: "주소 찾기",
                popupKey: 'popup1'
            }
        )
    };

    const phoneCheck = () => {
        // TODO :: 차후 서비스 오픈시 아임포트를 이용하여 휴대폰 인증을 할 예정
    }


    const emailCheck = async () => {
        if (emails === '') {
            SWAL.fire('', '이메일을 입력해주세요', 'warning');
        } else {

            try {
                setLoading(true); // 로딩 시작
                setIsTimerActive(true);
                const response = await axios.post('http://localhost:8000/handle_email_code/', {
                    emails: emails
                })

                if (response.data.error === '이미 인증된 메일 입니다.') {
                    setLoading(false);
                    await SWAL.fire({
                        icon: 'error',
                        text: response.data.error,
                        showConfirmButton: false,
                        timer: 1000
                    })
                } else {
                    setLoading(false);
                    setIsOpen(true);
                    setTimeLeft(300);
                    await SWAL.fire({
                        icon: 'success',
                        text: response.data.message,
                        showConfirmButton: false,
                        timer: 1000
                    })
                }


            } catch (error) {
                let {response}: any = error;
                if (response.status === 401) {
                    await SWAL.fire({
                        icon: 'error',
                        text: '이메일 주소를 확인해주세요'
                    })
                }
            }
        }


    }
    return (
        <div className="sign_up">
            <h1 className="title">회원가입</h1>
            <form className="join__form" onSubmit={handleSubmit}>
                {/* 아이디 입력 */}
                <div>
                    <label className="label">아이디</label>
                    <p style={{fontSize:"15px"}}>(4자리 이상 16자리 이하 문자,숫자로 입력해주세요.)</p>
                    <input className="input" type="text" name="id" value={formData.id}
                           onChange={handleInputChange}/>
                </div>
                {/* 이메일 입력 */}
                <div>
                    <label className="label">이메일</label>
                    {isEmailConfirm ?
                        (<input className="input" type="text" name="email" value={formData.email} readOnly={true}/>) :
                        (<input className="input" type="text" name="email" value={formData.email}
                                onChange={handleInputChange}/>)
                    }
                </div>
                {isEmailConfirm ? (
                    <p style={{color:"green"}}>이메일 인증이 완료되었습니다.</p>
                ) : (
                    <button
                        className="email_confirm"
                        onClick={emailCheck}
                        type="button"
                        style={{marginBottom: "20px"}}
                    >
                        {isOpen ? "다시 이메일 인증" : "이메일 인증"}
                    </button>
                )}
                {isOpen ? <EmailVerificationModal
                    setIsEmailConfirm={setIsEmailConfirm}
                    timeLeft={timeLeft}
                    isTimerActive={isTimerActive}
                    isOpen={isOpen}
                    onClose={() => setIsOpen(false)}
                /> : ''}
                {isLoading && <div className="loading">{Loading()}</div>}
                {/* 비밀번호 입력 */}
                <div>
                    <label className="label">비밀번호</label>
                    <span style={{fontSize: "10px"}}>영어, 숫자, 특수문자를 포함하여 8자리 이상 입력해주세요.</span>
                    <input className="input" type="password" name="pw" value={formData.pw}
                           onChange={handleInputChange}/>
                </div>
                {/* 비밀번호 확인 입력 */}
                <div>
                    <label className="label">비밀번호 확인</label>
                    <input
                        className={`
                        input ${validatePasswordMatch() ? 'match' : 'not-match'}`}
                        type="password"
                        name="pw2"
                        value={formData.pw2}
                        onChange={handleInputChange}
                    />
                    {formData.pw2 && (
                        <span className={`
                              password - match - icon ${validatePasswordMatch() ? 'match' : 'not-match'}`}
                              style={{color: validatePasswordMatch() ? 'green' : 'red', float: 'right'}}>
                            {validatePasswordMatch() ? '비밀번호 일치' : '비밀번호 불일치'}
                        </span>
                    )}
                </div>
                {/* 이름 입력 */}
                <div>
                    <label className="label">이름</label>
                    <input className="input" type="text" name="name" value={formData.name}
                           onChange={handleInputChange}/>
                </div>
                {/* 휴대폰 번호 입력 */}
                <div>
                    <label className="label">휴대폰 번호</label>
                    <input className="input" type="text" name="phone_number" value={formData.phone_number}
                           onChange={handleInputChange}/>
                </div>
                {/* 주소 입력 */}
                <div>
                    <label className="label">주소</label>
                    <input className="input" type="text" name="address" readOnly={true} id="address"
                           onClick={handleClick} style={{marginBottom: 6}}
                           value={formData.address = address} onChange={handleInputChange}/>

                    <input className="input" name="address_detail" type="text" value={formData.address_detail}
                           placeholder="상세주소를 입력해주세요."
                           onChange={handleInputChange}/>

                </div>
                {/* SMS 수신동의 */}
                <div className="agree__sms">
                    <div>
                        <p style={{fontSize: '10px'}}>각종 이벤트와 신상품 관련 안내에 대한 메시지 전달을 원하시면 체크해주세요</p>
                        <input
                            type="checkbox"
                            name="sms_agree"
                            checked={formData.sms_agree}
                            onChange={handleInputChange}
                        />
                        <label className="checkbox-label">SMS 수신동의</label>
                    </div>
                </div>
                {/* 제출 버튼 */}
                <button className="button" type="submit">
                    제출
                </button>
            </form>
        </div>
    );
}

export default Signup;
