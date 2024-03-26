import React, {useState} from "react";
import DatePicker from "react-datepicker";
import {ko} from "date-fns/esm/locale";
import {format} from "date-fns";
import "../styles/reservation/Reservation.css";
import CarSelectModal from '../components/CarSelectModal'

function Reservation() {
    const [selectedDate, setSelectedDate] = useState(null);
    const [selectedTime, setSelectedTime] = useState(null);
    const [isShow, setIsShow] = useState(false)
    const [reservationInfo, setReservationInfo] = useState({
        category: "",
        carType: "",
        name: "",
        password: "",
        phoneNumber: "",
        email: "",
        details: "",
    });

    const handleDateChange = (date: any) => {
        setSelectedDate(date);
    };

    const handleTimeClick = (time: any) => {
        setSelectedTime(time);
    };

    const handleInputChange = (e: any) => {
        const {name, value} = e.target;
        setReservationInfo({...reservationInfo, [name]: value});
    };

    const handleSubmit = (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault();
        // 예약 정보를 서버로 보내거나 필요한 처리를 수행하세요.
        console.log("예약 정보:", {
            date: selectedDate ? format(selectedDate, "yyyy-MM-dd") : "",
            time: selectedTime ? format(selectedTime, "a hh:mm") : "",
            ...reservationInfo,
        });
    };
    // 09:00부터 20:00까지의 시간 범위 생성
    const timeRange = Array.from({length: 13}, (_, index) => {
        const hour = 9 + index;
        const formattedHour = hour.toString().padStart(2, "0");
        return `${formattedHour}:00`;
    });

    const showCarSelectModal = () => {
        setIsShow(true);
    }


    return (
        <div className="reservation-container">
            <h2>예약페이지</h2>
            <form className="reservation-form" onSubmit={handleSubmit}>
                <div className="form-group">
                    <label>일자 선택</label>
                    <div className="datepicker-container">
                        <DatePicker
                            selected={selectedDate}
                            showTimeSelect={false}
                            onChange={handleDateChange}
                            dateFormat="yyyy년 MM월 dd일"
                            locale={ko}
                            minDate={new Date()}
                            maxDate={new Date(new Date().setMonth(new Date().getMonth() + 3))}
                            inline
                        />
                    </div>
                </div>
                <div className="form-group">
                    <label>시간 선택</label>
                    <div className="time-buttons">
                        {timeRange.map((time) => (
                            <button
                                type="button"
                                key={time}
                                onClick={() => handleTimeClick(time)}
                                className={selectedTime === time ? "active" : ""}
                            >
                                {time}
                            </button>
                        ))}
                    </div>
                </div>
                <div className="form-group">
                    <label>예약 분류</label>
                    <select
                        name="category"
                        onChange={handleInputChange}
                        value={reservationInfo.category}
                    >
                        <option value="">선택하세요</option>
                        <option value="clean">세차</option>
                        <option value="counselling">상담</option>
                    </select>
                </div>
                <div className="form-group">
                    <label>차종 분류</label>
                    <input
                        type="carType"
                        onClick={showCarSelectModal}
                        value={reservationInfo.carType}
                        readOnly
                    />
                    {isShow ? <CarSelectModal isShow={isShow} onClose={() => setIsShow(false)}/> : ''}

                </div>
                <div className="form-group">
                    <label>성함</label>
                    <input
                        type="text"
                        name="name"
                        onChange={handleInputChange}
                        value={reservationInfo.name}
                    />
                </div>
                <div className="form-group">
                    <label>비밀 번호</label>
                    <input
                        type="password"
                        name="password"
                        onChange={handleInputChange}
                        value={reservationInfo.password}
                    />
                </div>
                <div className="form-group">
                    <label>전화번호</label>
                    <input
                        type="tel"
                        name="phoneNumber"
                        onChange={handleInputChange}
                        value={reservationInfo.phoneNumber}
                    />
                </div>
                <div className="form-group">
                    <label>이메일</label>
                    <input
                        type="email"
                        name="email"
                        onChange={handleInputChange}
                        value={reservationInfo.email}
                    />
                </div>
                <div className="form-group">
                    <label>예약 내용</label>
                    <textarea
                        className="details"
                        name="details"
                        onChange={handleInputChange}
                        value={reservationInfo.details}
                    />
                </div>
                <div className="form-group">
                    <label>자동등록방지</label>
                    <input type="text"/>
                    <button type="button">숫자 음성 듣기</button>
                    <button type="button" style={{marginBottom: "10px"}}>새로고침</button>
                </div>
                <div className="form-group">
                    <button type="submit">예약</button>
                </div>
            </form>
        </div>
    );
}

export default Reservation;
