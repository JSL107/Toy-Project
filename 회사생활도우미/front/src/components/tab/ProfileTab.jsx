// ProfileTab 컴포넌트

import {Button, Form, DatePicker, notification, Typography, Input} from "antd";
import {CalendarOutlined, PhoneOutlined, UserOutlined} from "@ant-design/icons";
import {useState} from "react";
import styles from './Profile.module.css';
import {validateFormData} from "../../utils/function/UserValidCheck.js";

const {Title} = Typography;

export function ProfileTab() {
    const [profileFormData, setProfileFormData] = useState({
        username: '',
        birthday: '',
        contact: ''
    });

    const [formErrors, setFormErrors] = useState({
        username: '',
        email: '',
        password: '',
        birthday: ''
    });

    const handleSaveProfile = () => {
        const errors = validateFormData(profileFormData);
        setFormErrors(errors);

        if (errors !== '') {
            notification.error({
                message: '프로필 저장에 실패하였습니다.'
            })
        } else {
            notification.success({
                message: '프로필 정보가 저장되었습니다.',
            });
        }
    };

    const handleProfileFormChange = (value, name) => {
        setProfileFormData({...profileFormData, [name]: value});
    };

    const onChange = (date, dateString) => {
        setProfileFormData({...profileFormData, birthday: dateString});
    };

    return (
        <div>
            <Title level={3} className={styles.title}>프로필 정보 수정</Title>
            <Form className={styles.form}>
                <Form.Item label="사용자명" className={styles.formItem}>
                    <Input prefix={<UserOutlined/>} value={profileFormData.username}
                           onChange={(e) => handleProfileFormChange(e.target.value, 'username')}
                           className={styles.input}/>
                </Form.Item>
                <Form.Item>
                    <DatePicker
                        format={{
                            format: 'YYYY-MM-DD',
                            type: 'mask',
                        }}
                        placeholder="생년월일 (YYYY-MM-DD)"
                        className={styles.input}
                        onChange={onChange}
                    />
                </Form.Item>
                <Form.Item label="연락처" className={styles.formItem}>
                    <Input prefix={<PhoneOutlined/>} value={profileFormData.contact}
                           onChange={(e) => handleProfileFormChange(e.target.value, 'contact')}
                           className={styles.input}/>
                </Form.Item>
                <Button type="default" onClick={handleSaveProfile} className={styles.button}>저장</Button>
            </Form>
        </div>
    )
}
