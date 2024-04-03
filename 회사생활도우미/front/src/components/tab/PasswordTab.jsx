import {Button, Form, Input, notification, Typography} from "antd";
import {LockOutlined} from "@ant-design/icons";
import {useState} from "react";
import styles from './Password.module.css'
import {isValidPassword} from "../../utils/regex/UserRegex.js";

const {Title} = Typography;

export function PasswordTab() {
    const [passwordFormData, setPasswordFormData] = useState({
        currentPassword: '',
        newPassword: '',
        confirmPassword: ''
    });

    const [passwordError, setPasswordError] = useState(false);
    const [message, setMessage] = useState('')
    const handlePasswordFormChange = (value, name) => {
        setPasswordFormData(prevState => ({...prevState, [name]: value}));
        if (name === 'confirmPassword' || name === 'newPassword') {
            if (value !== passwordFormData.newPassword && value !== passwordFormData.confirmPassword) {
                setMessage('비밀번호가 일치하지 않습니다.');
                setPasswordError(false);
            } else {
                setMessage('비밀번호가 일치합니다.');
                setPasswordError(true);
            }
        }
    };
    const handlePasswordChange = () => {

        const result = isValidPassword(passwordFormData.newPassword);
        // const isSamePassword
        if (result && passwordError) {
            notification.success({
                message: '비밀번호가 변경되었습니다.',
            });

        } else {
            notification.error({
                message: '변경에 실패하였습니다.',
                description: '변경될 비밀번호는 같아야하며 패스워드는 8글자 이상 문자, 숫자, 특수문자를 포함 해야 합니다.',
            });
        }

    };

    return (
        <div className={styles.passwordSection}>
            <Title level={1} className={styles.title}>비밀번호 변경</Title>
            <Form className={styles.form}>
                <Form.Item label="현재 비밀번호">
                    <Input.Password prefix={<LockOutlined/>} value={passwordFormData.currentPassword}
                                    onChange={(e) => handlePasswordFormChange(e.target.value, 'currentPassword')}
                                    className={styles.input}/>
                </Form.Item>
                <Form.Item label="새 비밀번호">
                    <Input.Password prefix={<LockOutlined/>} value={passwordFormData.newPassword}
                                    onChange={(e) => handlePasswordFormChange(e.target.value, 'newPassword')}
                                    className={styles.input}/>
                </Form.Item>
                <Form.Item label="비밀번호 확인">
                    <Input.Password prefix={<LockOutlined/>} value={passwordFormData.confirmPassword}
                                    onChange={(e) => handlePasswordFormChange(e.target.value, 'confirmPassword')}
                                    className={styles.input}/>
                    <span
                        className={passwordError ? styles.success : styles.error}>{message}
                    </span>
                </Form.Item>
                <Button type="default" onClick={handlePasswordChange} className={styles.button}>변경</Button>
            </Form>
        </div>
    )
}
