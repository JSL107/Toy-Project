import {useState} from 'react';
import {Layout, Menu, Typography, Tabs, ConfigProvider} from 'antd';
import styles from './MyPage.module.css';
import {ProfileTab} from "../../components/tab/ProfileTab.jsx";
import {PasswordTab} from "../../components/tab/PasswordTab.jsx";
import {DeleteUserTab} from "../../components/tab/DeleteUserTab.jsx";
import {AlarmSettingTab} from "../../components/tab/AlarmSettingTab.jsx";
import {CalendarSettingTab} from "../../components/tab/CalendarSettingTab.jsx";
import {Link} from "react-router-dom";

const {Title} = Typography;
const {Content, Sider} = Layout;

const tabItems = [
    {key: "1", children: <ProfileTab/>},
    {key: "2", children: <PasswordTab/>},
    {key: "3", children: <DeleteUserTab/>},
    {key: "4", children: <AlarmSettingTab/>},
    {key: "5", children: <CalendarSettingTab/>}
];

const menuItems = [
    /* TODO 1 :: 프로필 정보 수정전 현재 비밀번호를 입력받아 인가 과정 필요
    *  TODO 2 :: 이메일 인증 관련 로직 필요
    *  TODO 3 :: 프로필 정보 수정 페이지 기존 데이터 불러오기 기능 필요
    *  TODO 4 :: 활동 정보 수집 기능 필요 */
    {key: "1", label: "프로필 정보 수정"},
    {key: "2", label: "비밀번호 변경"},
    {key: "3", label: "계정 삭제"},
    {key: "4", label: "알림 설정"},
    {key: "5", label: "일정 관리"}
];

const MyPage = () => {
    const [activeTab, setActiveTab] = useState('1'); // 활성 탭 상태 추가
    const [isHover, setIsHover] = useState(false);
    // 사이드바 메뉴 클릭 핸들러
    const handleMenuClick = (e) => {
        // setActiveTab(e); // 클릭된 메뉴 아이템의 키를 활성 탭으로 설정
        setActiveTab(e.key)
    };

    return (
        <Layout className={styles.layout}>
            <Sider width={200} className={styles.sider}>
                <div className={styles.logo}>
                    <Title level={3} className={styles.title} style={{marginBottom: 0}}
                           onMouseEnter={() => setIsHover(true)} onMouseOut={() => setIsHover(false)}>
                        {isHover ? (
                            <Link to={'/'}>
                                <div style={{color: "black"}}>Home</div>
                            </Link>) : (<div>My Page</div>)}
                    </Title>
                </div>
                <ConfigProvider
                    theme={{
                        components: {
                            Menu: {
                                horizontalItemHoverColor: "#FFC26F",
                                itemSelectedBg: "#FFC26F",
                                itemSelectedColor: "#884A39"
                            }
                        }
                    }}>
                    <Menu
                        defaultSelectedKeys={['1']}
                        selectedKeys={[activeTab]}
                        className={styles.menu}
                        onClick={handleMenuClick}
                        items={menuItems}
                    />
                </ConfigProvider>
            </Sider>
            <Layout>
                <Content className={styles.content}>
                    <Tabs activeKey={activeTab} className={styles.tabs} items={tabItems}/>
                </Content>
            </Layout>
        </Layout>
    )
}

export default MyPage;
