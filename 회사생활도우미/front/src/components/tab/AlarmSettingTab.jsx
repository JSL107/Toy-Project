// AlarmSettingTab.jsx

import {Checkbox, Divider, Typography, TimePicker, Button} from "antd";
import {useState} from "react";
import styles from "./AlarmSetting.module.css";

const {Title, Text} = Typography;

export function AlarmSettingTab() {
    const [emailNotification, setEmailNotification] = useState(false);
    const [phoneNotification, setPhoneNotification] = useState(false);
    const [anniversaryAlarm, setAnniversaryAlarm] = useState(false);
    const [doNotDisturb, setDoNotDisturb] = useState(false);

    const handleEmailNotificationChange = (e) => {
        setEmailNotification(e.target.checked);
    };

    const handlePhoneNotificationChange = (e) => {
        setPhoneNotification(e.target.checked);
    };

    const handleAnniversaryAlarmChange = (e) => {
        setAnniversaryAlarm(e.target.checked);
    };

    const handleDoNotDisturbChange = (e) => {
        setDoNotDisturb(e.target.checked);
    };

    const handleSaveSettings = () => {
        // Save settings logic
        console.log("Settings saved!");
    };

    return (
        <div className={styles.container}>
            <Title level={1} className={styles.title}>알림 설정</Title>
            <div className={styles.notificationItem}>
                <Checkbox
                    checked={emailNotification}
                    onChange={handleEmailNotificationChange}
                >
                    <Text className={styles.checkboxLabel}>이메일 알림</Text>
                </Checkbox>
            </div>
            <Divider/>
            <div className={styles.notificationItem}>
                <Checkbox
                    checked={phoneNotification}
                    onChange={handlePhoneNotificationChange}
                >
                    <Text className={styles.checkboxLabel}>휴대폰 알림</Text>
                </Checkbox>
            </div>
            <Divider/>
            <div className={styles.notificationItem}>
                <Checkbox
                    checked={anniversaryAlarm}
                    onChange={handleAnniversaryAlarmChange}
                >
                    <Text className={styles.checkboxLabel}>기념일 알림</Text>
                </Checkbox>
                {anniversaryAlarm && (
                    <div>
                        <div className={styles.subItem}>
                            <Checkbox>생일</Checkbox>
                        </div>
                        <div className={styles.subItem}>
                            <Checkbox>결혼 기념일</Checkbox>
                        </div>
                        <div className={styles.subItem}>
                            <Checkbox>기념일</Checkbox>
                        </div>
                        {/* Add more subcategories here */}
                    </div>
                )}
            </div>
            <Divider/>
            <div className={styles.notificationItem}>
                <Checkbox
                    checked={doNotDisturb}
                    onChange={handleDoNotDisturbChange}
                >
                    <Text className={styles.checkboxLabel}>방해 금지 모드</Text>
                </Checkbox>
                {doNotDisturb && (
                    <div className={styles.doNotDisturb}>
                        <Text className={styles.subLabel}>시작 시간:</Text>
                        <TimePicker className={styles.timePicker}/>
                        <Text className={styles.subLabel}>종료 시간:</Text>
                        <TimePicker className={styles.timePicker}/>
                    </div>
                )}
            </div>
            <Divider/>
            <Button type="default" onClick={handleSaveSettings} className={styles.button}>저장</Button>
        </div>
    );
}
