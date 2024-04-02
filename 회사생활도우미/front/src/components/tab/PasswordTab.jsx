import {Button, Form, Input, notification, Typography} from "antd";
import styles from "../../pages/user/MyPage.module.css";
import {LockOutlined} from "@ant-design/icons";
import {useState} from "react";

const {Title} = Typography;

export function PasswordTab() {
    const [passwordFormData, setPasswordFormData] = useState({
        currentPassword: '',
        newPassword: '',
        confirmPassword: ''
    });
    const handlePasswordFormChange = (value, name) => {
        setPasswordFormData({...passwordFormData, [name]: value});
    };
    const handlePasswordChange = () => {
        notification.success({
            message: '비밀번호가 변경되었습니다.',
        });
    };

    return (
        <div>
            <Title level={3}>비밀번호 변경</Title>
            <Form className={styles.form}>
                <Form.Item label="현재 비밀번호">
                    <Input.Password prefix={<LockOutlined/>} value={passwordFormData.currentPassword}
                                    onChange={(e) => handlePasswordFormChange(e.target.value, 'currentPassword')}/>
                </Form.Item>
                <Form.Item label="새 비밀번호">
                    <Input.Password prefix={<LockOutlined/>} value={passwordFormData.newPassword}
                                    onChange={(e) => handlePasswordFormChange(e.target.value, 'newPassword')}/>
                </Form.Item>
                <Form.Item label="비밀번호 확인">
                    <Input.Password prefix={<LockOutlined/>} value={passwordFormData.confirmPassword}
                                    onChange={(e) => handlePasswordFormChange(e.target.value, 'confirmPassword')}/>
                </Form.Item>
                <Button type="primary" onClick={handlePasswordChange}>변경</Button>
            </Form>
        </div>
    )
}
