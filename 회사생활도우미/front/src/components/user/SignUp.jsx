import React, {useState} from 'react';
import {Link} from 'react-router-dom';
import {Form, Input, Button, Typography} from 'antd';
import {UserOutlined, LockOutlined, MailOutlined, CalendarOutlined} from '@ant-design/icons';
import styles from './SignUp.module.css';
import {validateFormData} from "../../utils/function/UserValidCheck.js";

const {Title} = Typography;

const Signup = () => {
    const [formData, setFormData] = useState({
        id: '',
        username: '',
        email: '',
        password: '',
        birthday: ''
    });

    const [formErrors, setFormErrors] = useState({
        id: '',
        username: '',
        email: '',
        password: '',
        birthday: ''
    });

    const handleChange = (e) => {
        const {name, value} = e.target;
        setFormData({...formData, [name]: value});
        setFormErrors({...formErrors, [name]: ''});

        // 생년월일 입력 시 자동으로 "-" 추가
        if (name === 'birthday' && value.length === 4) {
            setFormData({...formData, [name]: value + '-'});
        } else if (name === 'birthday' && value.length === 7) {
            setFormData({...formData, [name]: value + '-'});
        } else {
            setFormData({...formData, [name]: value});
        }
    };

    const handleSubmit = () => {
        const errors = validateFormData(formData);
        setFormErrors(errors);

        if (Object.keys(errors).length === 0) {
            // 회원 가입 처리
        }
    };

    return (
        <div className={styles.signupContainer}>
            <Title level={2} className={styles.title}>회원 가입</Title>
            <Form onFinish={handleSubmit} className={styles.form}>
                <Form.Item
                    className={styles.inputGroup}
                    validateStatus={formErrors.id ? 'error' : ''}
                    help={formErrors.id}
                >
                    <Input
                        prefix={<UserOutlined/>}
                        type="text"
                        name="id"
                        value={formData.id}
                        onChange={handleChange}
                        placeholder="ID"
                        className={styles.input}
                    />
                </Form.Item>
                <Form.Item
                    className={styles.inputGroup}
                    validateStatus={formErrors.username ? 'error' : ''}
                    help={formErrors.username}
                >
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
                <Form.Item
                    className={styles.inputGroup}
                    validateStatus={formErrors.email ? 'error' : ''}
                    help={formErrors.email}
                >
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
                <Form.Item
                    className={styles.inputGroup}
                    validateStatus={formErrors.password ? 'error' : ''}
                    help={formErrors.password}
                >
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
                <Form.Item
                    className={styles.inputGroup}
                    validateStatus={formErrors.birthday ? 'error' : ''}
                    help={formErrors.birthday}
                >
                    <Input
                        prefix={<CalendarOutlined/>}
                        type="text"
                        name="birthday"
                        value={formData.birthday}
                        onChange={handleChange}
                        placeholder="생년월일 (YYYY-MM-DD)"
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
