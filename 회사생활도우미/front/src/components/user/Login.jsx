import {useState} from 'react';
import styles from './Login.module.css';
import {Input, Button, Typography, Checkbox} from 'antd';
import {
    UserOutlined,
    LockOutlined,
    EyeInvisibleOutlined,
    EyeTwoTone, ArrowLeftOutlined
} from '@ant-design/icons';
import NaverLogo from '../../assets/naver_logo.png';
import KakaoLogo from '../../assets/kakao_logo.png';
import GoogleLogo from '../../assets/google_logo.png';
import {Link, useNavigate} from 'react-router-dom'; // 설치한 패키지


const {Title, Text} = Typography;

export function Login() {
    const [username, setUsername] = useState('');
    const [password, setPassword] = useState('');
    const [showPassword, setShowPassword] = useState(false);
    const [rememberMe, setRememberMe] = useState(false);

    const navigate = useNavigate();

    const handleUsernameChange = (event) => {
        setUsername(event.target.value);
    };

    const handlePasswordChange = (event) => {
        setPassword(event.target.value);
    };

    const handleTogglePasswordVisibility = () => {
        setShowPassword(!showPassword);
    };

    const handleRememberMeChange = (event) => {
        setRememberMe(event.target.checked);
    };

    const handleSubmit = (event) => {
        event.preventDefault();
        // 여기서 로그인 처리를 수행합니다. (예: API 호출 등)
        setUsername('');
        setPassword('');
        // 로그인 후에 필요한 작업을 수행합니다. (예: 리디렉션)
    };

    function goToMain() {
        navigate('/');
    }

    return (
        <div className={styles.loginContainer}>
            <div className={styles.loginHeader}>
                <ArrowLeftOutlined style={{fontSize: "25px", cursor: "pointer"}} onClick={goToMain}/>
                <Title level={3} className={styles.title} style={{userSelect: "none"}}>회사도우미</Title>
            </div>
            <form onSubmit={handleSubmit}>
                <div className={styles.formGroup}>
                    <Input
                        prefix={<UserOutlined/>}
                        type="text"
                        value={username}
                        onChange={handleUsernameChange}
                        placeholder="사용자명"
                        className={styles.input}
                        variant={"borderless"}
                    />
                </div>
                <div className={styles.formGroup}>
                    <Input.Password
                        prefix={<LockOutlined/>}
                        value={password}
                        onChange={handlePasswordChange}
                        placeholder="비밀번호"
                        className={styles.input}
                        iconRender={visible => (visible ? <EyeTwoTone/> : <EyeInvisibleOutlined/>)}
                        variant={"borderless"}
                    />
                </div>
                <div className={styles.checkboxGroup}>
                    <Checkbox checked={rememberMe} onChange={handleRememberMeChange} className={styles.checkBox}>로그인 상태
                        유지</Checkbox>
                </div>
                <div className={styles.buttonGroup}>
                    <Button type="default" htmlType="submit" className={styles.loginButton}>
                        로그인
                    </Button>
                </div>
                <Text className={styles.socialLoginText}>또는</Text>
                <div className={styles.socialLoginGroup}>
                    <Button type="default" className={styles.kakaoButton}
                            icon={<img src={KakaoLogo} alt={''} className={styles.kakaoLogo}/>}>KAKAO</Button>
                    <Button type="default" className={styles.naverButton}
                            icon={<img src={NaverLogo} alt={''} className={styles.naverLogo}/>}>
                        <Text style={{marginLeft: 0}}>NAVER</Text>
                    </Button>
                    <Button type="default" className={styles.googleButton}
                            icon={<img src={GoogleLogo} alt={''} className={styles.googleLogo}/>}>GOOGLE</Button>
                </div>
                <Text className={styles.forgotLink}>
                    <Button type="link" className={styles.signupButton}>
                        <Link to={'/sign-up'}>회원 가입</Link>
                    </Button>
                    <Button type="link" className={styles.findID}>계정 찾기</Button>
                    <span className={styles.separator} style={{userSelect: "none"}}>|</span>
                    <Button type="link" className={styles.findPW}>비밀번호 찾기</Button>
                </Text>
            </form>
        </div>
    );
}
