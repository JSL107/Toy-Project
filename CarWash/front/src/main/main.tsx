import React, {useEffect, useState} from "react";
import "react-alice-carousel/lib/alice-carousel.css";
import AliceCarousel from 'react-alice-carousel';
import styled from 'styled-components';
import '../styles/main/main.css'
import axios from "axios";
import {useNavigate} from "react-router-dom";

const imageData = [
    {
        label: "image1",
        alt: "",
        url: 'https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg',
    }
]

function Main() {
    const navigate = useNavigate();

    const handleDragStart = (e: any) => e.preventDefault();

    const responsive = {
        0: {
            items: 2,
        }, 512: {
            items: 4,
        },
    };

    const [boardList, setBoardList] = useState<any[]>([]);

    useEffect(() => {
        async function fetchBoardList() {
            try {
                const response = await axios.get('http://localhost:8000/board_list/');
                if (response.data.response_code) {
                    console.log(response.data)
                    setBoardList(response.data.board_list);
                } else {
                    console.log('Failed to fetch board list');
                }
            } catch (error) {
                console.error('Error fetching board list:', error);
            }
        }

        fetchBoardList();
    }, []);

    function formatDate(timestamp: string | number | Date) {
        const date = new Date(timestamp);
        const year = date.getFullYear();
        const month = ('0' + (date.getMonth() + 1)).slice(-2);
        const day = ('0' + date.getDate()).slice(-2);
        const hours = ('0' + date.getHours()).slice(-2);
        const minutes = ('0' + date.getMinutes()).slice(-2);
        return `${year}-${month}-${day} ${hours}:${minutes}`;
    }

    const clickBoard = (e: React.MouseEvent<HTMLDivElement>, id: number): void => {
        e.preventDefault();
        navigate(`/board_detail`, {state: id});
    };

    function board() {
        const sortedBoardList = boardList.slice().sort((a, b) => b.write_date - a.write_date);
        return (
            <div className="post_section">
                {sortedBoardList.slice(0, 5).map((board, index) => (
                        <div className="post_info_section" key={board.id} onClick={(e) => clickBoard(e, board.id)}>
                            <h4 key={board.title}>{board.title}</h4>
                            <div className="image_section">
                                <img key={board.image} src={board.image} alt=""/>
                            </div>
                            <li key={board.write_date}>{formatDate(+new Date(board.write_date))}</li>
                        </div>
                    )
                )}
            </div>

        );
    }

    function bestSeller() {
        return (
            <div className="product_section">
                <img src="https://www.seiu1000.org/sites/main/files/main-images/camera_lense_0.jpeg" alt=""/>
                <div className="product_info_section">
                    <p>상품명</p>
                    <p>가격</p>
                    <p>상품설명</p>
                </div>
            </div>
        )
    }


    const items = imageData.map((image) => {
        return (
            <ItemsContain>
                <ItemsWrap>
                    <img src={image.url} alt=""/>
                </ItemsWrap>
            </ItemsContain>
        )
    })
    return (
        <>
            <div className="main_swiper">
                <Contain onDragStart={handleDragStart}>
                    <AliceCarousel
                        mouseTracking
                        infinite={true}
                        animationDuration={5000}
                        disableDotsControls
                        disableButtonsControls
                        responsive={responsive}
                        autoPlay
                        items={items}
                        paddingRight={40}
                    />
                </Contain>
            </div>
            <h2>최근 게시물</h2>
            {board()}

            <div className="BestSeller_section">
                <h2>Best Seller</h2>
                <p>TITLE 베스트셀러 상품을 소개합니다.</p>
            </div>
            {bestSeller()}


        </>


    )
}

const Contain = styled.div`
  width: 100%;
  display: flex;
  align-items: center;
  margin: 0 auto;
`

const ItemsContain = styled.div`
  margin-top: 20px;
  width: 100%;
  height: 100%;
  padding: 0 10px;
`

const ItemsWrap = styled.div`
  width: 100%;
  height: 300px;
  border-radius: 20px;
  overflow: hidden;
  margin: 0 20px;

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
`
export default Main