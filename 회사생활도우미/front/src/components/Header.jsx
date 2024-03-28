import style from './header.module.css';
import PersonIcon from '@mui/icons-material/Person';
import NotificationsActiveIcon from '@mui/icons-material/NotificationsActive';

export default function Header() {

    return (
        <div>
            <header className={style.header}>
                <div className={style.item_section}>
                    <div className={style.title_section}>
                        <h3 className={style.title}>회사 도우미</h3>
                    </div>
                    <div className={style.icon_section}>
                        <PersonIcon className={style.person}/>
                        <NotificationsActiveIcon className={style.Notification}/>
                    </div>
                </div>
            </header>
        </div>
    );
}
