import {Button, Form, Input, notification, Typography} from "antd";
import styles from "../../pages/user/MyPage.module.css";
import {MailOutlined} from "@ant-design/icons";
import {useState} from "react";

const {Title} = Typography;

export function EmailTab() {

    const [emailFormData, setEmailFormData] = useState({
        currentEmail: '',
        newEmail: ''
    });
    const handleEmailChange = () => {
        notification.success({
            message: '이메일 주소가 변경되었습니다.',
        });
    };
    const handleEmailFormChange = (value, name) => {
        setEmailFormData({...emailFormData, [name]: value});
    };

    return (
        <div>
            <Title level={3}>이메일 주소 변경</Title>
            <Form className={styles.form}>
                <Form.Item label="현재 이메일 주소">
                    <Input prefix={<MailOutlined/>} value={emailFormData.currentEmail}
                           onChange={(e) => handleEmailFormChange(e.target.value, 'currentEmail')}/>
                </Form.Item>
                <Form.Item label="새 이메일 주소">
                    <Input prefix={<MailOutlined/>} value={emailFormData.newEmail}
                           onChange={(e) => handleEmailFormChange(e.target.value, 'newEmail')}/>
                </Form.Item>
                <Button type="primary" onClick={handleEmailChange}>변경</Button>
            </Form>
        </div>
    )
}
