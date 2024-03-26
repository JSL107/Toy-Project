import React, {useState} from 'react';
import {Link} from 'react-router-dom'
import '../styles/components/header.css'
import axios from "axios";
import {NavDropdown} from "react-bootstrap";
import Reservation from "../reservation/Reservation";

function Header({onLogout}) {
    const [show, setShow] = useState('');
    const showDropdown = (e) => {
        setShow(e.target.id);
    }
    const hideDropdown = e => {
        setShow('');
    }
    const handleLogout = () => {
        localStorage.removeItem('token');
        // axios default headers 초기화
        delete axios.defaults.headers.common['Authorization'];
        // onLogout 콜백 실행
        onLogout();
        window.location.reload();
    };

    let isHave;
    isHave = localStorage.getItem('token') !== null;

    return (
        <header>
            <div className="board">
                <NavDropdown title="게시판" id="board_nav"
                             show={show === "board_nav"}
                             onMouseEnter={showDropdown}
                             onMouseLeave={hideDropdown}>
                    <NavDropdown.Item href="/boardlist/notice">공지사항</NavDropdown.Item>
                    <NavDropdown.Item href="/boardlist">전체게시글</NavDropdown.Item>
                    <NavDropdown.Item href="/boardlist/work">작업게시글</NavDropdown.Item>
                </NavDropdown>
            </div>
            <div className="reservation">
                <Link to='/reservation' className="link_header">예약</Link>
            </div>
            <div className="title">
                <h3>
                    <Link to="/" className="link_header">TITLE</Link>
                </h3>
            </div>
            <div className="login">
                {isHave ? (
                    <Link to="/" className="link_header" onClick={handleLogout}>로그아웃</Link>
                ) : (
                    <Link to="/login" className="link_header">로그인</Link>
                )}
            </div>
            <div className="mypage">
                {isHave ? (
                    <NavDropdown title="마이페이지" id="my_page_nav"
                                 show={show === "my_page_nav"}
                                 onMouseEnter={showDropdown}
                                 onMouseLeave={hideDropdown}>
                        <NavDropdown.Item href="/boardlist">회원정보</NavDropdown.Item>
                        <NavDropdown.Item href="/boardlist">구매내역</NavDropdown.Item>
                        <NavDropdown.Item href="/boardlist">내가 쓴글</NavDropdown.Item>
                    </NavDropdown>
                ) : (
                    <Link to="/login" className="link_header">마이페이지</Link>
                )}
            </div>
            <div className="basket">
                <Link to="/" className="link_header">장바구니</Link>
            </div>
        </header>
    );
}

export default Header;