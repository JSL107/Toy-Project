import {useState} from 'react';
import {Layout, Menu, Typography, Tabs, ConfigProvider} from 'antd';
import styles from './MyPage.module.css';
import {ProfileTab} from "../../components/tab/ProfileTab.jsx";
import {PasswordTab} from "../../components/tab/PasswordTab.jsx";
import {EmailTab} from "../../components/tab/EmailTab.jsx";
import {DeleteUserTab} from "../../components/tab/DeleteUserTab.jsx";
import {AlarmSettingTab} from "../../components/tab/AlarmSettingTab.jsx";
import {CalendarSettingTab} from "../../components/tab/CalendarSettingTab.jsx";

const {Title} = Typography;
const {Content, Sider} = Layout;

const tabItems = [{key: "1", children: <ProfileTab/>}, {key: "2", children: <PasswordTab/>}, {
    key: "3",
    children: <EmailTab/>
}, {key: "4", children: <DeleteUserTab/>}, {key: "5", children: <AlarmSettingTab/>}, {
    key: "6",
    children: <CalendarSettingTab/>
}];

const menuItems = [{key: "1", label: "프로필 정보 수정"}, {key: "2", label: "비밀번호 변경"}, {
    key: "3",
    label: "이메일 주소 변경"
}, {key: "4", label: "계정 삭제"}, {key: "5", label: "알림 설정"}, {key: "6", label: "일정 관리"}];

const MyPage = () => {
    const [activeTab, setActiveTab] = useState('1'); // 활성 탭 상태 추가

    // 사이드바 메뉴 클릭 핸들러
    const handleMenuClick = (e) => {
        // setActiveTab(e); // 클릭된 메뉴 아이템의 키를 활성 탭으로 설정
        setActiveTab(e.key)
    };


    return (
        <Layout className={styles.layout}>
            <Sider width={200} className={styles.sider}>
                <div className={styles.logo}>
                    <Title level={3} className={styles.title} style={{marginBottom: 0}}>마이페이지</Title>
                </div>
                <ConfigProvider
                    theme={{
                        components: {
                            Menu: {
                                horizontalItemHoverColor: "#FFC26F",
                                itemSelectedBg: "#FFC26F",
                                itemSelectedColor : "#884A39"
                            }
                        }
                    }}>
                    < Menu
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
