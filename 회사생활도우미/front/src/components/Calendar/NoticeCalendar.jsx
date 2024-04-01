import FullCalendar from '@fullcalendar/react';
import dayGridPlugin from '@fullcalendar/daygrid';
import interactionPlugin from '@fullcalendar/interaction';
import {Modal} from "antd";
import {useState} from "react";
import dayjs from "dayjs";
import 'dayjs/locale/ko';
import styles from './NoticeCalender.module.css';

dayjs.locale('ko');

function FullCalendarPage() {
    const events = [
        {title: 'Meeting 1', event: 'work', start: new Date(), end: new Date(), backgroundColor: "#292eaa"},
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
    const onCloseClick = () => {
        setIsModalOpen(false);
    }
    const dateClick = ({date}) => {
        setIsModalOpen(true);
        const formattedDate = dayjs(date).format("MM월 DD일 일정");
        setCalendarTitle(formattedDate);

        const clickedDateEvents = events.filter(event => dayjs(event.start).isSame(date, 'day'));
        if (clickedDateEvents.length > 0) {
            setHasEvent(clickedDateEvents);
        } else {
            setHasEvent([{title: '일정이 없습니다.'}]);
        }
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
                   footer={null} zIndex={9999}>
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
        </div>
    );
}

export default FullCalendarPage;
