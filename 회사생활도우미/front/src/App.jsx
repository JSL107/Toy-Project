import style from './App.module.css'
import NoticeCalendar from "./components/calendar/NoticeCalendar.jsx";
import Header from "./components/Header.jsx";


function App() {

    return (
        <>
            <Header/>
            <div className={style.main}>
                <div className={style.widget_section}>
                    <div className={style.weather_widget}>
                        <p>날씨</p>
                    </div>
                    <div className={style.dday}>
                        <p>오늘의 일정</p>
                    </div>
                </div>
                <div className={style.content_section}>
                    <div className={style.todo}>
                        <p>TO-DO</p>
                    </div>
                    <div className={style.board}>
                        <p>게시글</p>
                    </div>
                    <div className={style.calender}>
                        <NoticeCalendar/>
                    </div>
                </div>
            </div>
        </>
    )
}

export default App
