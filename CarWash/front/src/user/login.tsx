import React, {useEffect, useState} from 'react';
import '../styles/user/login.css';
import {useNavigate} from "react-router-dom"; // Login.css 파일의 경로
import axios from 'axios';
import SWAL from "sweetalert2";

interface LoginProps {
    onLogin: () => void; // onLogin prop의 타입 정의
    loggedInProp: boolean; // loggedIn prop의 타입 정의
}

function Login({onLogin, loggedInProp}: LoginProps) {
    const navigate = useNavigate();
    const [user_id, setUser_id] = useState('');
    const [password, setPassword] = useState('');
    const [loggedIn, setLoggedIn] = useState(false);
    const handleUsernameChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setUser_id(event.target.value);
    };

    const handlePasswordChange = (event: React.ChangeEvent<HTMLInputElement>) => {
        setPassword(event.target.value);
    };

    const handleLogin = async (event: React.FormEvent<HTMLFormElement>) => {
        event.preventDefault();
        try {
            const response = await axios.post('http://127.0.0.1:8000/login/', {
                user_id,
                password,
            });

            if (response.status === 200) {
                const token = response.data.results.access_token;
                if (token) {
                    localStorage.setItem('token', token);
                    axios.defaults.headers.common['Authorization'] = `Bearer ${token}`;
                    setLoggedIn(true);
                    onLogin(); // 부모 컴포넌트의 로그인 상태 업데이트 함수 호출
                    navigate('/', {state: {isLogin: true, user_id: user_id}});
                }
            } else {
                console.error('Login failed');
            }
        } catch (error: any) {
            SWAL.fire({
                icon: 'error',
                text: '아이디나 비밀번호를 확인해주세요',
                showConfirmButton: false,
                timer: 1000
            })
        }
    };

    const handleOpenForgotPassword = () => {
        navigate('/new_password')
    };

    const [currentSlide, setCurrentSlide] = useState(0);

    // ... 여러 이미지 URL 추가
    let images = [
        'https://images.unsplash.com/photo-1520340356584-f9917d1eea6f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1931&q=80',
        'https://images.unsplash.com/photo-1575844611398-2a68400b437c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2072&q=80',
        'https://images.unsplash.com/photo-1605164598708-25701594473e?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80',
        'https://images.unsplash.com/photo-1543857182-68106299b6b2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2071&q=80',
    ];

    useEffect(() => {
        const interval = setInterval(() => {
            setCurrentSlide((prevSlide) => (prevSlide + 1) % images.length);
        }, 3000);

        return () => clearInterval(interval);
    }, [images]);

    const goToSignUp = () => {
        navigate('/join')
    }
    return (
        <div style={{display: "flex"}}>
            <div className={`login-container${loggedIn ? ' logged-in' : ''}`}>
                <div className="form-container">
                    {loggedIn ? (
                        <div className="login-success">
                            <h2>Login Successful!</h2>
                            <p>Welcome, {user_id}!</p>
                        </div>
                    ) : (
                        <form onSubmit={handleLogin}>
                            <h2>Login</h2>
                            <div className="input-group">
                                <label htmlFor="user_id">ID</label>
                                <input
                                    type="text"
                                    id="user_id"
                                    value={user_id}
                                    onChange={handleUsernameChange}
                                    placeholder="Enter your ID"
                                />
                            </div>
                            <div className="input-group">
                                <label htmlFor="password">Password</label>
                                <input
                                    type="password"
                                    id="password"
                                    value={password}
                                    onChange={handlePasswordChange}
                                    placeholder="Enter your password"
                                />
                            </div>
                            <button type="submit" className="btn">로그인</button>
                            <p className="link" onClick={handleOpenForgotPassword}>비밀번호 찾기</p>

                            <p className="link" onClick={goToSignUp}>회원가입</p>
                            <p className="link">비회원 이용</p>
                            <p className="link">비회원 주문내역</p>
                        </form>
                    )}
                </div>
            </div>
            <div className="slideshow">
                {images.map((image, index) => (
                    <div
                        key={index}
                        className={`slide ${index === currentSlide ? 'active' : ''}`}
                        style={{backgroundImage: `url(${image})`}}
                    />
                ))}
            </div>
        </div>

    );
}

export default Login;
