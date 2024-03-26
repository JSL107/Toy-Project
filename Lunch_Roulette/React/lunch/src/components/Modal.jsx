import React, {useRef, useState} from "react";
import styled from "styled-components";
import Swal from "sweetalert2";

function Modal({onClose, values}) {

    let [text, setText] = useState('');
    let [, setState] = useState('');
    let [, setEditText] = useState('');
    let addMenu = useRef('');


    let handleChange = (e) => {
        setText(addMenu.current.value);
    }
    const addItem = (e) => {
        if (text === '') {
            Swal.fire('메뉴를 입력해주세요', '', 'warning')
            addMenu.current.focus();
        } else {
            values.push({option: text});
            e.target.value = '클릭'
            setState(e.target.value)

            setTimeout(() => {
                setState('')
            }, 1)
            // 여기서도 null 값 방지와 함께 DB에 접근하여 값 추가할 수 있도록 처리

        }
    };

    const menuEditInput = (e) => {
        setEditText(e.target.value);
    };

    const pressEnter = (e) => {
        if (e.keyCode === 13) {
            e.target.value = document.getElementById(e.target.id).value
            editButtonClick(e)
        }
    }
    const editButtonClick = (e) => {
        values[e.target.id].option = document.getElementById(e.target.id).value;
        e.target.value = document.getElementById(e.target.id).value
        if (e.target.value !== '' && e.target.value !== null) {
            setEditText(e.target.value);
        } else {
            Swal.fire('메뉴를 입력해주세요', '', 'warning')
        }
        setState(e.target.value)
        setTimeout(() => {
            setState('c')
        }, 1)
        // 여기서도 수정하면 DB에서 수정될 수 있게 alert 알림 후에 DB에 값 적용 제목에 null 값은 방지
    }

    const menuList = values.map((menu, value) => (
        <div style={{marginRight: "4%"}}>
            <li id={value + menu} style={{
                listStyle: "none",
                float: "left",
                width: "35%",
                marginBottom: "2%",
                fontFamily: "DOSPilgiMedium"
            }}
                key={value + menu}>{values[value].option}</li>

            <input id={value} onChange={menuEditInput} onKeyDown={pressEnter}
                   style={{
                       listStyle: "none", width: "50%", marginBottom: "2%", float: "left", outline: "none",
                       backgroundColor: "rgb(233, 233, 233)",
                       border: "0",
                       borderRadius: "15px",
                       height: "20px"
                   }}/>

            <input className="edit" id={value} type="button" value="수정"
                   onClick={editButtonClick} style={{
                fontFamily: "DOSPilgiMedium",
                backgroundColor: "#ababab",
                borderRadius: "10px",
                color: "white",
                cursor: "pointer",
                marginLeft: "5%",
                marginBottom: "2%",
                float: "left"
            }}/>
        </div>)
    );
    return (
        <Overlay>
            <ModalWrap>
                <h1 style={{
                    fontFamily: "DOSPilgiMedium",
                    color: "black",
                    fontSize: "30px",
                    fontWeight: "600",
                    marginBottom: "60px",
                }}>메뉴 수정</h1>
                <Contents>
                    <div style={{marginBottom: "10%"}}>
                        <li style={{
                            listStyle: "none",
                            width: "80%",
                            fontSize: "20px",
                            fontWeight: "bold",
                            float: "right",
                            marginBottom: "10%",
                            fontFamily: "DOSPilgiMedium"
                        }}>추가할 메뉴
                            <input onChange={handleChange} type="text" ref={addMenu} style={{
                                float: "right",
                                marginRight: "20%",
                                borderRadius: "15px",
                                outline: "none",
                                backgroundColor: "rgb(233, 233, 233)",
                                border: "0",
                                width: "200px",
                                height: "20px"
                            }}></input>
                        </li>
                    </div>
                    {menuList}
                </Contents>
                <div>
                    <Button onClick={addItem} style={{float: "left", width: "45%"}}>메뉴 추가</Button>
                    <Button onClick={() => onClose()} style={{float: "left", width: "45%"}}>닫기</Button>
                </div>
            </ModalWrap>

        </Overlay>

    );


}

const Overlay = styled.div`
  position: fixed;
  width: 100%;
  height: 100%;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(0, 0, 0, 0.2);
  z-index: 1000;
  overflow: auto;
`;

const ModalWrap = styled.div`
  width: 700px;
  height: fit-content;
  border-radius: 15px;
  background-color: #777e96;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  align-content: center;
  text-align: center;
`;

const Contents = styled.div`
  margin: 30px 30px;


  li {
    text-align: center;
    font-size: 15px;
  }

  img {
    margin-top: 60px;
    width: 300px;
  }

`;
const Button = styled.button`
  margin-top: 5%;
  font-family: "DOSPilgiMedium", serif;
  font-size: 14px;
  padding: 5px 20px;
  border: none;
  background-color: #ababab;
  border-radius: 10px;
  color: white;
  font-style: italic;
  font-weight: 200;
  cursor: pointer;
  margin-left: 3%;

  &:hover {
    background-color: #f27008;
  }
`;

export default Modal;