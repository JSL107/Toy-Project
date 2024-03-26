import React, {useEffect, useState} from "react";
import {useLocation, useNavigate} from "react-router-dom";
import axios from "axios";
import {Paper, Typography, Divider, IconButton} from "@mui/material";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import "../styles/board/board.css";

function Board() {
    const {state} = useLocation();
    const [boardData, setBoardData] = useState<any>(null);
    const navigate = useNavigate();

    useEffect(() => {
        async function fetchBoardList() {
            try {
                const response = await axios.get(
                    `http://localhost:8000/board_detail/${state}`
                );
                if (response.data.response_code === "success") {
                    setBoardData(response.data);
                } else {
                    console.log("Failed to fetch board list");
                }
            } catch (error) {
                console.error("Error fetching board list:", error);
            }
        }

        fetchBoardList();
    }, [state]);

    if (!boardData) {
        return <div>Loading...</div>;
    }

    return (
        <div className="boardContainer">
            <Paper elevation={3} className="boardPaper">
                <div className="boardHeader">
                    <IconButton
                        onClick={() => {
                            navigate(-1);
                        }}
                        className="backButton"
                    >
                        <ArrowBackIcon/>
                    </IconButton>
                    <Typography variant="h4" className="boardTitle">
                        {boardData.title}
                    </Typography>
                </div>
                <Typography variant="subtitle1" className="boardDate">
                    작성일자: {boardData.write_date}
                </Typography>
                <Divider/>
                <div className="boardContent">
                    {boardData.image && (
                        <img
                            src={boardData.image}
                            alt="Board Image"
                            className="boardImage"
                        />
                    )}
                    <Typography variant="body1" className="boardContext">
                        {boardData.context}
                    </Typography>
                </div>
            </Paper>
        </div>
    );
}

export default Board;
