import React, {useEffect, useState} from 'react'
import Swal from "sweetalert2";
import {Wheel} from 'react-custom-roulette'
import './style.css'
import Modal from '../../components/Modal';
import ExcelModal from "../Modal/ExcelModal";
import axios from "axios";

// 차후에 데이터베이스와 연결해서 가져올 부분
let data = [
    {option: '0', optionSize: 0},
    {option: '1', optionSize: 0},
    {option: '2', optionSize: 0},
    {option: '3', optionSize: 0}
];

const colorData = [];

// 룰렛의 색상을 랜덤으로 지정하기 위한 코드
function getRandomColor() {
    for (const element of data) {
        const letters = '0123456789ABCDEF';
        let color = '#';
        for (let i = 0; i < 6; i++) {
            color += letters[Math.floor(Math.random() * 16)];
            // 검정방지
            if (color === '#000000' || color === '#ffffff') {
                getRandomColor();
            }
        }
        colorData.push(color);
    }

}

export default () => {
    let [state, setState] = useState(data);

    let [jdata, setJData] = useState([{}]);
    useEffect(() => {
        axios.get('http://localhost:8000/get').then((res) => {
            setJData(res.data);
            console.log(res.data);
        })
    }, [])
    getRandomColor();

    // Wheel에 data형태에 맞게 배열 재선언
    let newArr = [];
    // 재선언된 배열에 데이터 넣기
    jdata.map((x) => {
        let y = {};
        y['key'] = x['restaurant_key']
        y['option'] = x['restaurant_name'];
        // 가중치를 가시화 하기 위한 코드
        if (10 - x['visit_time'] > 0) {
            y['optionSize'] = 10 - x['visit_time'];
        }
        y['location'] = x['restaurant_location'];
        newArr.push(y);
    });


    const [mustSpin, setMustSpin] = useState(false);
    const [prizeNumber, setPrizeNumber] = useState(0);
    const handleSpinClick = () => {
        if (!mustSpin) {
            const newPrizeNumber = Math.floor(Math.random() * state.length);
            setPrizeNumber(newPrizeNumber);
            setMustSpin(true);
            setTimeout(() => {
                Swal.fire({
                    icon: "info",
                    title: state[newPrizeNumber].option,
                    text: "방문횟수: " + Math.abs(10-state[newPrizeNumber].optionSize),
                    confirmButtonColor: "#f27008",
                    confirmButtonText: "확인",
                    showCloseButton: true,
                })
            }, 11500)
            // 당첨됨과 동시에 DB에서 방문횟수 값 업데이트
            if (state[newPrizeNumber].key !== undefined) {
                axios.put('http://localhost:8000/update/' + state[newPrizeNumber].key);
            }
        }
    }


    const [isOpen, setIsOpen] = useState(false);
    const [isOpenExcelModal, setIsOpenExcelModal] = useState(false);
    const openModal = () => {
        setIsOpen(true);
    }
    const openExcelModal = () => {
        setIsOpenExcelModal(true);
    }

    const [isChecked, setIsChecked] = useState(false);
    const onCheck = (e) => {
        if (e.target.checked) {
            setState(newArr);
            setIsChecked(e.target.checked);
        } else {
            setState(data);
            setIsChecked(e.target.checked);
        }
    }

    const save = () => {
        console.log(isChecked);
        if (isChecked) {
            Swal.fire({
                title: '저장',
                text: 'DB에 저장하시겠습니까?',
                type: "warning",
                icon: "question",
                showCancelButton: true,
                confirmButtonClass: "btn-danger",
                confirmButtonText: "예",
                cancelButtonText: "아니오",
                closeOnConfirm: false,
                closeOnCancel: true
            }).then((res) => {
                if (res.isConfirmed) {
                    try {
                        // 저장하였을 때 axios 통신을 위한 코드
                        //
                        setTimeout(() => {
                            Swal.fire('완료', '성공', 'success')
                        }, 1000);
                    } catch (e) {
                        Swal.fire("오류", "등록중 오류가 발생하였습니다.", "warning")
                    }
                }
            });
        } else {
            Swal.fire({
                icon: "warning",
                title: '알림',
                text: '해당 기능은 DB & 가중치 활성화 후에 사용가능합니다.',
                confirmButtonColor: "#f27008",
                confirmButtonText: "확인",
                showCloseButton: true,
            })
        }
    }
    return (<div id="Roulette_Area">
        <h2 className="title">Roulette</h2>
        <div style={{float: "left"}}>
            <li style={{fontSize: "15px", listStyle: "none", fontStyle: ""}}>DB & 가중치 활성화</li>
            <input className="check_button" role="switch" type="checkbox" style={{float: "left", marginLeft: "0px"}}
                   onChange={e => {
                       onCheck(e)
                   }}/>
        </div>
        <br/>
        <Wheel
            // key 속성을 추가하여 데이터 변경 시마다 렌더링을 강제
            key={JSON.stringify(state)}
            startingOptionIndex={Math.floor(Math.random() * state.length)}
            mustStartSpinning={mustSpin}
            prizeNumber={prizeNumber}
            data={state}
            veticalText={true}
            textColors={['#ffffff']}
            backgroundColors={colorData}
            fontSize={15}
            onStopSpinning={() => {
                setMustSpin(false);
            }}
        >
        </Wheel>
        <button className="save_button" style={{float: "right"}} onClick={save}>현재 상태 저장하기</button>
        <br/>
        <div className="button_section">
            <button className="spin_button" onClick={handleSpinClick}>돌려!</button>
            <button className="edit_menu" onClick={openModal}>메뉴수정</button>
            {isOpen && (<Modal open={isOpen} onClose={() => {
                setIsOpen(false);
            }} values={state}/>)}
            <button className="excel_modal" onClick={openExcelModal}>엑셀 불러오기</button>
            {isOpenExcelModal && (<ExcelModal open={isOpenExcelModal} onClose={() => {
                setIsOpenExcelModal(false);
            }} values={state}/>)}
        </div>

    </div>)
}