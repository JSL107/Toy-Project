import style from './header.module.css';
import PersonIcon from '@mui/icons-material/Person';
import NotificationsActiveIcon from '@mui/icons-material/NotificationsActive';
import {useRef, useState} from "react";
import {ListItemButton, List, Input, Drawer} from '@mui/joy';
import {Search, Menu} from '@mui/icons-material';

export default function Header() {
    const [open, setOpen] = useState(false);
    const searchText = useRef();
    const searchButtonClick = () => {
        console.log(searchText.current.value);
        searchText.current.value = '';
    }
    const onKeyDownEnter = ((e) => {
        // code for enter
        if (e.keyCode === 13) {
            searchButtonClick();
        }
    });

    return (<div>
        <header className={style.header}>
            <div className={style.item_section}>
                <div className={style.drawer_section}>
                    <Menu onClick={() => setOpen(true)} className={style.icon_button}/>
                    <Drawer open={open} onClose={() => setOpen(false)}>
                        <Input
                            onKeyDown={(e) => onKeyDownEnter(e)}
                            size="sm"
                            placeholder="Search"
                            variant="plain"
                            endDecorator={<Search onClick={searchButtonClick}/>}
                            slotProps={{
                                input: {
                                    ref: searchText,
                                    'aria-label': 'Search anything',
                                },
                            }}
                            sx={{
                                m: 3,
                                borderRadius: 0,
                                borderBottom: '2px solid',
                                borderColor: 'neutral.outlinedBorder',
                                '&:hover': {
                                    borderColor: 'neutral.outlinedHoverBorder',
                                },
                                '&::before': {
                                    border: '1px solid var(--Input-focusedHighlight)',
                                    transform: 'scaleX(0)',
                                    left: 0,
                                    right: 0,
                                    bottom: '-2px',
                                    top: 'unset',
                                    transition: 'transform .15s cubic-bezier(0.1,0.9,0.2,1)',
                                    borderRadius: 0,
                                },
                                '&:focus-within::before': {
                                    transform: 'scaleX(1)',
                                },
                            }}
                        />
                        <List
                            size="lg"
                            component="nav"
                            sx={{
                                flex: 'none', fontSize: 'xl', '& > div': {justifyContent: 'center'},
                            }}

                        >
                            <ListItemButton>Home</ListItemButton>
                            <ListItemButton>About</ListItemButton>
                            <ListItemButton>Studio</ListItemButton>
                            <ListItemButton>Contact</ListItemButton>
                        </List>
                    </Drawer>
                </div>

                <div className={style.title_section}>
                    <h3 className={style.title}>회사 도우미</h3>
                </div>
                <div className={style.icon_section}>
                    <PersonIcon className={style.person}/>
                    <NotificationsActiveIcon className={style.Notification}/>
                </div>
            </div>
        </header>
    </div>)
}
