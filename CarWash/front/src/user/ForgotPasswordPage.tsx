import React, {useEffect, useState} from 'react';
import '../styles/user/ForgotPasswordPage.css';
import axios from 'axios';
import SWAL from "sweetalert2";
import Loading from "../components/Loading";
import {useNavigate} from "react-router-dom";

// 이 부분 추가
axios.defaults.xsrfCookieName = 'csrftoken';
axios.defaults.xsrfHeaderName = 'X-CSRFToken';

enum ForgotPasswordStep {
    NamePhoneNumber,
    Email,
    Verification,
    Password,
}


function ForgotPasswordPage() {
    const [isLoading, setLoading] = useState(false);
    const [step, setStep] = useState(ForgotPasswordStep.NamePhoneNumber);
    const [name, setName] = useState('');
    const [phoneNumber, setPhoneNumber] = useState('');
    const [verificationCode, setVerificationCode] = useState('');
    const [newPassword, setNewPassword] = useState('');
    const [confirmedPassword, setConfirmedPassword] = useState('');
    const [isTimerActive, setIsTimerActive] = useState(false);
    const [timeLeft, setTimeLeft] = useState(300); // 초기 시간 설정 (초단위)
    const navigate = useNavigate();
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

    const handleNamePhoneNumberSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        // 휴대폰 번호의 유효성 검사
        if (/^\d{10,11}$/.test(phoneNumber) && /^[가-힣a-zA-Z]*$/.test(name)) {
            try {
                setLoading(true); // 로딩 시작
                // 서버에 POST 요청 보내기
                const response = await axios.post('http://localhost:8000/send-verification-code/', {
                    name: name,
                    phone_number: phoneNumber,
                });

                // 응답 처리
                await SWAL.fire({
                    icon: 'success',
                    text: response.data.message,
                    showConfirmButton: false,
                    timer: 1000
                })
                setIsTimerActive(true);
                setStep(ForgotPasswordStep.Verification);

            } catch (error) {
                let {response}: any = error;
                if (response.status === 401) {
                    await SWAL.fire({
                        icon: 'error',
                        text: '이름과 휴대폰 번호를 체크해주세요'
                    })
                }
            } finally {
                setLoading(false);
            }
        } else {
            await SWAL.fire({
                icon: 'error',
                text: '이름과 전화번호를 올바른 형태로 입력해주세요',
                showConfirmButton: false,
                timer: 1000
            })
        }

    };


    const handleVerificationSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        try {
            const response = await axios.post('http://localhost:8000/verify_verification_code/', {
                entered_code: verificationCode,
            });

            if (response.data.result === 'True') {
                setStep(ForgotPasswordStep.Password);
            } else {
                await SWAL.fire({
                    icon: 'error',
                    text: '인증번호를 확인해주세요',
                })
            }
        } catch (error: any) {
            await SWAL.fire({
                icon: 'error',
                text: error,
            })
        }

    };

    const handlePasswordChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setNewPassword(event.target.value);
    };

    const handleConfirmedPasswordChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setConfirmedPassword(event.target.value);
    };

    const handlePasswordSubmit = async (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();

        try {
            // 서버로 새로운 비밀번호 전송
            const response = await axios.post('http://localhost:8000/change-password/', {newPassword});

            if (response.status === 200) {
                // 비밀번호 변경 성공
                // 원하는 동작 수행 (예: 메시지 표시, 리다이렉션 등)

                await SWAL.fire({
                    icon: 'success',
                    text: response.data.message,
                    showConfirmButton: false,
                    timer: 1000
                });

                setTimeout(() => {
                    navigate('/login');
                }, 1000);  // 1초 후에 '/login'으로 이동

            } else {
                // 비밀번호 변경 실패
                await SWAL.fire({
                    icon: 'error',
                    text: response.data.message,
                });
            }
        } catch (error) {
            // 오류 처리
            console.error('비밀번호 변경 중 오류:', error);
        }
    };

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

    const isPasswordMatch = newPassword === confirmedPassword && newPassword !== '';

    return (
        <div className="forgot-password-page">
            <div className="forgot-password">
                <div className="forgot-password-header">
                    <h2>비밀번호 찾기</h2>
                </div>
                <div className="forgot-password-content">
                    {step === ForgotPasswordStep.NamePhoneNumber && (
                        <form onSubmit={handleNamePhoneNumberSubmit}>
                            <label htmlFor="name">이름</label>
                            <input
                                type="text"
                                id="name"
                                value={name}
                                onChange={(e) => setName(e.target.value)}
                            />
                            <label htmlFor="phoneNumber">휴대폰 번호</label>
                            <input
                                type="text"
                                id="phoneNumber"
                                value={phoneNumber}
                                onChange={(e) => setPhoneNumber(e.target.value)}
                            />
                            <button type="submit" className="modal-button">
                                확인
                            </button>
                            {isLoading && <div className="loading">{Loading()}</div>}
                        </form>
                    )}
                    {step === ForgotPasswordStep.Verification && (
                        <form onSubmit={handleVerificationSubmit}>
                            <p className={`timer-text ${!isTimerActive || timeLeft === 0 ? 'expired' : ''}`}>
                                {isTimerActive && timeLeft > 0 ? `남은 시간: ${timeLeft}초` : '시간이 만료되었습니다.'}
                            </p>
                            <label htmlFor="verificationCode">인증번호 입력</label>
                            <input
                                type="text"
                                id="verificationCode"
                                value={verificationCode}
                                onChange={(e) => setVerificationCode(e.target.value)}
                                disabled={!isTimerActive || timeLeft === 0} // 시간 만료 시 입력 비활성화
                            />
                            <button type="submit"
                                    className={`modal-button ${!isTimerActive || timeLeft === 0 ? 'expired' : ''}`}
                                    disabled={!isTimerActive || timeLeft === 0}>
                                인증 확인
                            </button>
                        </form>
                    )}
                    {step === ForgotPasswordStep.Password && (
                        <div>
                            <h2>새 비밀번호 입력</h2>
                            <form onSubmit={handlePasswordSubmit}>
                                <label htmlFor="newPassword">새 비밀번호 입력</label>
                                <input
                                    type="password"
                                    id="newPassword"
                                    value={newPassword}
                                    onChange={handlePasswordChange}
                                />
                                <label htmlFor="confirmedPassword">새 비밀번호 확인</label>
                                <input
                                    type="password"
                                    id="confirmedPassword"
                                    value={confirmedPassword}
                                    onChange={handleConfirmedPasswordChange}
                                />
                                {newPassword !== confirmedPassword && (
                                    <p className="password-match-error">비밀번호가 일치하지 않습니다.</p>
                                )}
                                <button type="submit" className="modal-button" disabled={!isPasswordMatch}>
                                    비밀번호 변경
                                </button>
                            </form>
                        </div>
                    )}
                </div>
            </div>
        </div>
    );
}

export default ForgotPasswordPage;
