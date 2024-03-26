import {useNavigate} from "react-router-dom";
import "../../styles/Main/Main.css"
import ramen from "../../assets/images/free-icon-ramen-2718224.png"
import "react-responsive-carousel/lib/styles/carousel.min.css";
import imageData from "../../assets/images/data";
import styled from 'styled-components';
import "react-alice-carousel/lib/alice-carousel.css";
import AliceCarousel from 'react-alice-carousel';
import * as xlsx from "xlsx";

const Main = () => {

    const responsive = {
        0: {
            items: 2,
        }, 512: {
            items: 4,
        },
    };

    const formDownLoad = () => {
        // 엑셀 파일 저장하는 코드
        const arr = [{'점심식당리스트': '', '위치': '', '종류[한식,중식,양식]': ''}];
        const ws = xlsx.utils.json_to_sheet(arr)
        const wb = xlsx.utils.book_new();
        xlsx.utils.book_append_sheet(wb, ws, "Sheet1");
        xlsx.writeFile(wb, "LunchRoulette.xlsx");
        // const cells =
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
    const handleDragStart = (e) => e.preventDefault();

    const navigate = useNavigate();
    const goTo = () => {
        navigate('/Roulette');
    }
    return (
        <div className="main_content">
            <div className="main_title">
                <div className="main_frame_logo">
                    <img className="main_title_icon" src={ramen} alt=""/>
                </div>
                <div className="main_frame">
                    <p>오늘 점심은 무엇을 먹을까요?</p>
                </div>

            </div>

            <div className="main_swiper">
                <Contain onDragStart={handleDragStart}>
                    <AliceCarousel
                        mouseTracking
                        infinite={1000}
                        animationDuration={1000}
                        disableDotsControls
                        disableButtonsControls
                        responsive={responsive}
                        autoPlay
                        items={items}
                        paddingRight={40}
                    />
                </Contain>
            </div>
            <button className="w-btn-outline" type="button" onClick={goTo}>
                <span></span>
            </button>
            <button className="w-btn-outline" type="button" onClick={formDownLoad}>
                엑셀 폼 다운받기
            </button>
        </div>


    )
};

export default Main;

const Contain = styled.div`
  width: 100%;
  display: flex;
  align-items: center;
  margin: 0 auto;
`

const ItemsContain = styled.div`
  width: 100%;
  height: 100%;
  padding: 0 10px;
`

const ItemsWrap = styled.div`
  width: 100%;
  height: 180px;
  border-radius: 20px;
  overflow: hidden;
  margin: 0 20px;

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
`