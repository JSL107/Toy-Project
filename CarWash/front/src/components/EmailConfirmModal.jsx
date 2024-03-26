import React, {useState} from 'react';
import '../styles/components/emailConfirmModal.css'
import axios from "axios";
import SWAL from "sweetalert2";

const EmailVerificationModal = ({isOpen, onClose, isTimerActive, timeLeft, setIsEmailConfirm}) => {
    const [verificationCode, setVerificationCode] = useState('');

    const handleVerificationSubmit = async (event) => {
        event.preventDefault();
        try {
            const response = await axios.post('http://localhost:8000/verify_verification_code/', {
                entered_code: verificationCode,
            });

            if (response.data.result === 'True') {
                onClose();
                setIsEmailConfirm(true);
            } else {
                await SWAL.fire({
                    icon: 'error',
                    text: '인증번호를 확인해주세요',
                })
            }
        } catch (error) {
            await SWAL.fire({
                icon: 'error',
                text: error,
            })
        }

    };
    return (
        <div className={`modal ${isOpen ? 'open' : ''}`}>
            <div className="modal-content email-confirmation-modal">
                <div className="modal-header">
                    <h3 className="modal-title">이메일 인증</h3>
                    <span className="close" onClick={onClose}>&times;</span>
                </div>
                <div className="modal-body">
                    <p className="modal-text">인증코드를 입력해주세요</p>
                    <input
                        type="text"
                        id="verificationCode"
                        value={verificationCode}
                        onChange={(e) => setVerificationCode(e.target.value)}
                        disabled={!isTimerActive || timeLeft === 0}
                        className="modal-input"
                    />
                    <button
                        onClick={handleVerificationSubmit}
                        className={`modal-button ${!isTimerActive || timeLeft === 0 ? 'expired' : ''}`}
                        disabled={!isTimerActive || timeLeft === 0}
                    >
                        인증 확인
                    </button>
                    <p className={`timer-text ${!isTimerActive || timeLeft === 0 ? 'expired' : ''}`}>
                        {isTimerActive && timeLeft > 0 ? `남은 시간: ${timeLeft}초` : '시간이 만료되었습니다.'}
                    </p>
                </div>
            </div>
        </div>
    );
}
export default EmailVerificationModal;