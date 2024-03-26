import {useNavigate} from "react-router-dom";
import "../styles/header.css"
import IMAGE_URL from "../assets/text/constant";
import React from "react";

const Header = () => {
    const navigate = useNavigate();
    const goTo = () => {
        navigate('/');
    }

    return (
        <header className="header">
            <img className="HomeLogo" src={`${IMAGE_URL.HanilIcon}`} alt="" onClick={goTo}/>
            <div className="Header-Title">
                <h2 className="h2-title"><span onClick={goTo}>오늘의 점심은?</span></h2>
            </div>
        </header>
    )
}
export default Header