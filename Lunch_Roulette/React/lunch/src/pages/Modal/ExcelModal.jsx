import '../../styles/Modal/ExcelModal.css'
import styled from "styled-components";
import React, {useRef, useState} from "react";
import * as XLSX from "xlsx";
import SWAL from "sweetalert2";


function ExcelModal({onClose, values}) {
    const fileInput = useRef(null);
    const [tempData, setTempData] = useState([]);
    let [, setState] = useState('');

    function handleFile(props) {
        console.log(props.target.files[0].name)
        const reader = new FileReader();
        reader.readAsArrayBuffer(props.target.files[0])
        if (props.target.files[0].name.split('.')[1] === 'xlsx') {
            reader.onload = (e) => {
                const bufferArray = e.target.result;
                const fileInformation = XLSX.read(bufferArray, {
                    type: 'buffer', cellText: false, cellDates: true,
                });
                const sheetName = fileInformation.SheetNames[0];
                const rawData = fileInformation.Sheets[sheetName];
                const data = XLSX.utils.sheet_to_json(rawData);
                setTempData(data);
            };
        } else {
            onClose();
            SWAL.fire(
                {
                    icon: "warning",
                    title: "경고",
                    text: "엑셀 파일의 형식이 아닙니다.",
                    confirmButtonColor: "#f27008",
                    confirmButtonText: "확인",
                    showConfirmButton: true
                }
            )
        }

    }

    const menuItem = (props) => {

        SWAL.fire({
            title: '수정하시겠습니까?',
            type: "warning",
            showCancelButton: true,
            confirmButtonClass: "btn-danger",
            confirmButtonText: "예",
            cancelButtonText: "아니오",
            closeOnConfirm: false,
            closeOnCancel: true
            // zIndex : 9999
        }).then((res) => {
            if (res.isConfirmed) {
                // 확인 처리 부분
                SWAL.fire('', '확인', 'success');

            } else {
                // 취소 처리 부분
                SWAL.fire('', '취소', 'error')
            }
        });
    };

    function menuClick() {
        SWAL.fire({
            title: '메뉴를 불러오시겠습니까?',
            type: "warning",
            icon: "question",
            showCancelButton: true,
            confirmButtonClass: "btn-danger",
            confirmButtonText: "예",
            cancelButtonText: "아니오",
            closeOnConfirm: false,
            closeOnCancel: true
            // zIndex : 9999
        }).then((res) => {
            if (res.isConfirmed) {
                try {
                    // 엑셀에 있는 데이터를 불러오기 위한 코드
                    values.length = 0;
                    tempData.map((number) => {
                        if (number.점심식당리스트 !== '계') {
                            values.push({option: number.점심식당리스트}
                            );
                        }
                    })
                    setState('클릭')
                    setTimeout(() => {
                        setState('')
                        onClose();
                        SWAL.fire('완료', '성공', 'success')
                    }, 1)
                } catch (e) {
                    SWAL.fire("파일 등록", "파일을 등록해주세요", "warning")
                }
            }
        });
    }

    const viewExcel = tempData.map((item, index) => (
        <table>
            <tr>
                <td id={index} onClick={menuItem} style={{padding: "10px"}}>{item.점심식당리스트}</td>
            </tr>
        </table>
    ))

    const handleClick = () => {
        fileInput.current.click();
    }

    return (
        <Overlay>

            <ModalWrap>
                <h1 style={{
                    fontFamily: "DOSPilgiMedium",
                    color: "black",
                    fontSize: "30px",
                    fontWeight: "600",
                    marginBottom: "30px",
                }}>엑셀 불러오기</h1>
                <li>
                    메뉴글자를 클릭하면 불러온 엑셀 파일이 적용됩니다.
                </li>
                <Contents>
                    <TR className="theader">
                        <th style={{width: "33%", padding: "10px"}} onClick={menuClick}>메뉴</th>
                    </TR>
                    {viewExcel}
                </Contents>
                <div>
                    <Button onClick={(e) => handleClick(e)} style={{float: "left", width: "45%"}}>엑셀 열기</Button>
                    <input id="open_file" type="file" onChange={(props) => handleFile(props)} ref={fileInput}
                           style={{display: "none"}}
                           accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"/>
                    <Button onClick={() => onClose()} style={{float: "left", width: "45%"}}>닫기</Button>
                </div>

            </ModalWrap>
        </Overlay>
    )
}

export default ExcelModal;
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
  //overflow: auto;
  //overflow: a;
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
  transform: translate(-50%, -30%);
  align-content: center;
  text-align: center;

  li {
    font-family: "DOSPilgiMedium", serif;
    font-size: 15px;
    color: darkred;
    list-style-type: none;
    margin-bottom: 20px;
  }
`;

const Contents = styled.div`
  //margin: 30px 30px;
  width: fit-content;
  height: fit-content;
  position: relative;
  align-content: center;
  transform: translate(-50%);
  left: 45%;


  tr {
    right: 100%;
    margin-left: 30px;
    text-align: center;
    align-items: center;
    font-size: 20px;
    float: right;
  }

  table {
    position: relative;
    left: 20%;
    align-items: center;
    text-align: center;
    //background: pink;
  }

`;

const TR = styled.tbody`
  font-family: "DOSPilgiMedium", serif;
  text-align: center;
  position: relative;
  left: 10%;
`
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