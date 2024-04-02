import {useState} from 'react';
import {Link} from 'react-router-dom';
import {Form, Input, Button, Typography} from 'antd';
import {UserOutlined, LockOutlined, MailOutlined} from '@ant-design/icons';
import styles from './SignUp.module.css';

const {Title} = Typography;

const Signup = () => {
    const [formData, setFormData] = useState({
        username: '',
        email: '',
        password: ''
    });

    const handleChange = (e) => {
        const {name, value} = e.target;
        setFormData({...formData, [name]: value});
    };

    const handleSubmit = (e) => {
        e.preventDefault();
        // 회원 가입 처리
    };

    return (
        <div className={styles.signupContainer}>
            <Title level={2} className={styles.title}>회원 가입</Title>
            <Form onFinish={handleSubmit} className={styles.form}>
                <Form.Item className={styles.inputGroup}>
                    <Input
                        prefix={<UserOutlined/>}
                        type="text"
                        name="username"
                        value={formData.username}
                        onChange={handleChange}
                        placeholder="사용자명"
                        className={styles.input}
                    />
                </Form.Item>
                <Form.Item className={styles.inputGroup}>
                    <Input
                        prefix={<MailOutlined/>}
                        type="email"
                        name="email"
                        value={formData.email}
                        onChange={handleChange}
                        placeholder="이메일"
                        className={styles.input}
                    />
                </Form.Item>
                <Form.Item className={styles.inputGroup}>
                    <Input.Password
                        prefix={<LockOutlined/>}
                        type="password"
                        name="password"
                        value={formData.password}
                        onChange={handleChange}
                        placeholder="비밀번호"
                        className={styles.input}
                    />
                </Form.Item>
                <Form.Item>
                    <Button type="default" htmlType="submit" className={styles.signupButton}>
                        회원 가입
                    </Button>
                </Form.Item>
            </Form>
            <div className={styles.loginLink}>
                이미 회원이신가요? <Link to="/login">로그인</Link>
            </div>
        </div>
    );
}

export default Signup;
