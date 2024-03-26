// BoardList.js

import React, {useEffect, useState} from "react";
import {useNavigate} from "react-router-dom";
import axios from "axios";
import {Typography, Pagination, Card, CardContent} from "@mui/material";
import "../styles/board/boardlist.css";
import {Category} from "@mui/icons-material";

function BoardList(category: any) {
    const [boardList, setBoardList] = useState<any[]>([]);
    const [totalItems, setTotalItems] = useState(0);
    const [currentPage, setCurrentPage] = useState(1);
    const itemsPerPage = 10; // 페이지당 아이템 개수
    const navigate = useNavigate();
    const [categories, setCategories] = useState(category.category);


    useEffect(() => {

        if (category.category === 'work') {
            setCategories('작업 게시판');
        } else if (category.category === 'notice') {
            setCategories('공지 사항');
        } else {
            setCategories('전체 게시판');
        }

        async function fetchBoardList(page: number) {
            try {
                const response = await axios.get(`http://localhost:8000/board_info/?page=${page}&itemsPerPage=${itemsPerPage}&category=${category.category}`);
                if (response.data.response_code) {
                    setBoardList(response.data.board_list);
                    setTotalItems(response.data.totalItems);
                } else {
                    console.log('Failed to fetch board list');
                }
            } catch (error) {
                console.error('Error fetching board list:', error);
            }
        }

        fetchBoardList(currentPage);
    }, [currentPage]);

    const handlePageChange = (event: React.ChangeEvent<unknown>, page: number) => {
        setCurrentPage(page);
    };

    const clickBoard = (e: React.MouseEvent<HTMLDivElement>, id: number) => {
        e.preventDefault();
        navigate(`/board_detail`, {state: id});
    };

    function formatDate(timestamp: string | number | Date) {
        const date = new Date(timestamp);
        const year = date.getFullYear();
        const month = ('0' + (date.getMonth() + 1)).slice(-2);
        const day = ('0' + date.getDate()).slice(-2);
        const hours = ('0' + date.getHours()).slice(-2);
        const minutes = ('0' + date.getMinutes()).slice(-2);
        return `${year}-${month}-${day} ${hours}:${minutes}`;
    }

    return (
        <div className="boardListContainer">

            <Typography variant="h4" sx={{marginBottom: 2}}>{categories}</Typography>
            <div className="boardItemContainer">
                {boardList.map((item, index) => (
                    <Card
                        key={item.id}
                        className="boardItem"
                        onClick={(e) => clickBoard(e, item.id)}
                    >
                        <img
                            className="boardItemImage"
                            src={item.image}
                            alt=""
                        />
                        <CardContent className="boardItemContent">
                            <Typography variant="h6" className="boardItemTitle">{item.title}</Typography>
                            <Typography className="boardItemMeta">{formatDate(item.write_date)}</Typography>
                        </CardContent>
                    </Card>
                ))}
            </div>
            <div className="paginationContainer">
                <Pagination
                    count={Math.ceil(totalItems / itemsPerPage)}
                    page={currentPage}
                    boundaryCount={2}
                    color="primary"
                    size="large"
                    onChange={handlePageChange}
                />
            </div>
        </div>
    );
}

export default BoardList;
