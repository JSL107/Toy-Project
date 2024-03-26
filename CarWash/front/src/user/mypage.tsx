import React, { useState } from 'react';
import '../styles/user/mypage.css';

interface Reservation {
    id: number;
    product: string;
    date: string;
    status: string;
}

function Mypage() {
    const [username, setUsername] = useState('더미 사용자 이름');
    const [selectedSection, setSelectedSection] = useState('profile');
    const [reservations, setReservations] = useState<Reservation[]>([
        {
            id: 1,
            product: '상품 A',
            date: '2023-08-25',
            status: '확정',
        },
        {
            id: 2,
            product: '상품 B',
            date: '2023-08-28',
            status: '대기 중',
        },
        // 예약 내역을 추가로 설정할 수 있습니다.
    ]);

    const handleSectionChange = (section: string) => {
        setSelectedSection(section);
    };

    return (
        <div className="container">
            <div className="sidebar">
                <a
                    href="#"
                    className="sidebar-link"
                    onClick={() => handleSectionChange('profile')}
                >
                    프로필
                </a>
                <a
                    href="#"
                    className="sidebar-link"
                    onClick={() => handleSectionChange('reservations')}
                >
                    예약 내역
                </a>
                {/* 다른 메뉴 항목들도 추가 */}
            </div>
            <div className="content">
                {selectedSection === 'profile' && (
                    <div>
                        <h2>프로필</h2>
                        <p>사용자 이름: {username}</p>
                        {/* 이메일 주소, 수정 버튼 등 프로필 섹션의 내용 */}
                    </div>
                )}
                {selectedSection === 'reservations' && (
                    <div>
                        <h2>예약 내역</h2>
                        <ul className="order-list">
                            {reservations.map((reservation) => (
                                <li key={reservation.id}>
                                    상품: {reservation.product}, 날짜: {reservation.date}, 상태: {reservation.status}
                                </li>
                            ))}
                        </ul>
                    </div>
                )}
                {/* 다른 섹션들 */}
                {selectedSection === 'orders' && (
                    <div>
                        <h2>주문 내역</h2>
                        {/* 주문 내역 관련 내용 */}
                    </div>
                )}
                {selectedSection === 'address' && (
                    <div>
                        <h2>배송 주소</h2>
                        {/* 배송 주소 관련 내용 */}
                    </div>
                )}
                {selectedSection === 'notifications' && (
                    <div>
                        <h2>알림 및 알림 설정</h2>
                        {/* 알림 관련 내용 */}
                    </div>
                )}
                {selectedSection === 'membership' && (
                    <div>
                        <h2>회원 등급 및 혜택</h2>
                        {/* 회원 등급 및 혜택 관련 내용 */}
                    </div>
                )}
                {selectedSection === 'password' && (
                    <div>
                        <h2>비밀번호 변경</h2>
                        {/* 비밀번호 변경 관련 내용 */}
                    </div>
                )}
                {selectedSection === 'deactivate' && (
                    <div>
                        <h2>탈퇴</h2>
                        {/* 계정 탈퇴 관련 내용 */}
                    </div>
                )}
                <button className="action-button">정보 업데이트</button>
            </div>
        </div>
    );
}

export default Mypage;