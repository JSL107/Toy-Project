import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import {Button, DatePicker, Modal, Select} from "antd";
import {useState} from "react";
import dayjs from "dayjs";
import 'dayjs/locale/ko';
import styles from './NoticeCalender.module.css';
import {PlusOutlined} from "@ant-design/icons";
import {Input, Option} from "@mui/joy";

const {RangePicker} = DatePicker;
dayjs.locale('ko');

function FullCalendarPage() {
    const events = [
        {
            title: 'Meeting 1',
            event: 'work',
            start: '2024-03-31',
            end: new Date(),
            backgroundColor: "#292eaa",
            borderColor: "#000"
        },
        {title: 'Meeting 2', event: 'work', start: new Date(), end: new Date(), backgroundColor: "#25aa2a"},
        {title: 'Meeting 3', event: 'work', start: new Date(), end: new Date(), backgroundColor: "#91c074"},
        {
            title: 'Meeting 4',
            event: 'work',
            start: new Date(),
            end: new Date(),
            backgroundColor: '#292eaa',
        },
    ]
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [calendarTitle, setCalendarTitle] = useState('');
    const [hasEvent, setHasEvent] = useState([]);
    const [isAddScheduleModalOpen, setIsAddScheduleModalOpen] = useState(false);
    const onCloseClick = () => {
        setIsModalOpen(false);
        setIsAddScheduleModalOpen(false);
    }
    const dateClick = ({date}) => {
        setIsModalOpen(true);
        const formattedDate = dayjs(date).format("MM월 DD일 일정");
        setCalendarTitle(formattedDate);

        const clickedDateEvents = events.filter(event =>
            dayjs(event.start).isSame(date, 'day') || dayjs(event.end).isSame(date, 'day')
        );
        if (clickedDateEvents.length > 0) {
            setHasEvent(clickedDateEvents);
        } else {
            setHasEvent([{title: '일정이 없습니다.'}]);
        }
    }

    const modalButton = () => (
        <Button shape={'circle'} type={"primary"} icon={<PlusOutlined/>} onClick={onClickAddSchedule}></Button>
    );

    const onClickAddSchedule = () => {
        setIsModalOpen(false)
        setIsAddScheduleModalOpen(true);
    }

    return (
        <div className={styles.calendarWrapper}>
            <FullCalendar
                locale="kr"
                plugins={[dayGridPlugin, interactionPlugin]}
                dateClick={dateClick}
                headerToolbar={{
                    left: '', center: 'title', right: 'prev,next today',
                }}
                events={events}
                dayMaxEvents={true}
                dayMaxEventRows={4}
                eventClick={dateClick}
                displayEventTime={false}
            />
            <Modal open={isModalOpen} onCancel={onCloseClick} centered={true} title={calendarTitle}
                   footer={modalButton} zIndex={9999}>
                {hasEvent.map((event, idx) => (
                    <div key={idx} className={styles.eventContainer}>
                        <div className={styles.eventDot} style={{backgroundColor: event.backgroundColor}}></div>
                        <div className={styles.contentSection}>
                            <p className={styles.eventTitle}>{event.title}</p>
                            <p className={styles.eventTime}>{event.start ? dayjs(event.start).format('HH:mm:ss') + ' ' : ''}</p>
                            <p className={styles.eventTime}>{event.end ? ' ~ ' + dayjs(event.end).format('HH:mm:ss') : ''}</p>
                        </div>
                    </div>
                ))}
            </Modal>
            <Modal open={isAddScheduleModalOpen} onCancel={onCloseClick} centered={true} title={'일정 추가하기'}>
                <div className={styles.addScheduleModalContent}>
                    <label className={styles.addScheduleLabel}>일정 제목:</label>
                    <Input className={styles.addScheduleInput}/>

                    <label className={styles.addScheduleLabel}>종류:</label>
                    <Select className={styles.addScheduleSelect}>
                        <Option value="meeting">미팅</Option>
                        <Option value="event">이벤트</Option>
                        <Option value="reminder">리마인더</Option>
                    </Select>

                    <label className={styles.addScheduleLabel}>기간:</label>
                    <RangePicker className={styles.addScheduleRangePicker}/>
                </div>
            </Modal>
        </div>
    );
}

export default FullCalendarPage;
