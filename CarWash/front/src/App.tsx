import React, {useState} from 'react';
import {BrowserRouter, Routes, Route} from "react-router-dom";

import "react-datepicker/dist/react-datepicker.css";
import Signup from './user/signup';
import Header from "./components/header";
import Footer from "./components/footer";
import Login from "./user/login";
import Main from "./main/main"
import BoardList from "./board/boardlist";
import Board from "./board/board";
import Mypage from "./user/mypage";
import ForgotPasswordPage from "./user/ForgotPasswordPage";
import Reservation from "./reservation/Reservation";


function App() {
    const [loggedIn, setLoggedIn] = useState(false);

    const handleLogin = () => {
        setLoggedIn(true);
    };

    const handleLogout = () => {
        setLoggedIn(false);
    };

    return (
        <BrowserRouter>
            <Header onLogout={handleLogout}/>
            <Routes>
                <Route path="/" element={<Main/>}/>
                <Route path="/join" element={<Signup/>}/>
                <Route
                    path="/login"
                    element={<Login onLogin={handleLogin} loggedInProp={loggedIn}/>} // prop 이름 변경
                />
                <Route path="/boardlist/notice" element={<BoardList category={"notice"}/>}/>
                <Route path="/boardlist" element={<BoardList category={""}/>}/>
                <Route path="/boardlist/work" element={<BoardList category={"work"}/>}/>
                {/* eslint-disable-next-line react/jsx-no-undef */}
                <Route path="/reservation" element={<Reservation/>}/>

                <Route path="/board_detail/*" element={<Board/>}/>
                <Route path="/mypage" element={<Mypage/>}/>
                <Route path="/new_password" element={<ForgotPasswordPage/>}/>

            </Routes>
            <Footer/>
        </BrowserRouter>
    );
}

export default App;
