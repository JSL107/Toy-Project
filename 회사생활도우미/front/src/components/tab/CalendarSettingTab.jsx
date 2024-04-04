import {Button, Typography, List, Space, Input, Modal} from "antd";
import styles from "./AlarmSetting.module.css";
import {SketchPicker} from "react-color";
import {useEffect, useState, useRef} from "react";

const {Title} = Typography;


export function CalendarSettingTab() {
    const [data, setData] = useState([
        {id: 1, category: '일'},
        {id: 2, category: '기념일'},
        {id: 3, category: '공휴일'}
    ]);

    const [buttonColors, setButtonColors] = useState(data.map(() => "#ffffff"));
    const [isPickerOpen, setIsPickerOpen] = useState(data.map(() => false));
    const [, setActivePickerIndex] = useState(null);
    const [isModalOpen, setIsModalOpen] = useState(false);
    const pickerContainersRef = useRef([]);
    const [categoryValue, setCategoryValue] = useState('');

    const handleChangeSketchPicker = (color, index) => {
        const newButtonColors = [...buttonColors];
        newButtonColors[index] = color.hex;
        setButtonColors(newButtonColors);
    };

    const handleChangeVisible = (index) => {
        setIsPickerOpen(prevState => prevState.map((state, idx) => idx === index ? !state : false)); // 다른 Picker는 닫음
        setActivePickerIndex(index);
    };

    const handleOutsideClick = (e) => {
        let isPickerClicked = false;
        pickerContainersRef.current.forEach((containerRef) => {
            if (containerRef?.contains(e.target)) {
                isPickerClicked = true;
            }
        });
        if (!isPickerClicked) {
            setIsPickerOpen(data.map(() => false));
            setActivePickerIndex(null);
        }
    };

    const handleModalOpen = () => {
        setIsModalOpen(true);
    }

    useEffect(() => {
        document.addEventListener('click', handleOutsideClick);
        return () => {
            document.removeEventListener('click', handleOutsideClick);
        };
    }, []);

    const handleSave = () => {
        console.log('저장');
    }

    const handleOk = () => {
        setIsModalOpen(false);
        setData(prevData => [
            ...prevData,
            {id: prevData.length + 1, category: categoryValue}
        ]);
    }

    const handleCancel = () => {
        setIsModalOpen(false);
    }


    return (
        <div className={styles.container}>
            <Title level={1} className={styles.title}>카테고리 관리</Title>
            <div>
                <List
                    dataSource={data}
                    renderItem={(item, index) => (
                        <List.Item key={item.id} className={styles.list}>
                            <Title level={5} className={styles.category}>{item.category}</Title>
                            <div ref={ref => pickerContainersRef.current[index] = ref}>
                                <Space>
                                    <Button style={{backgroundColor: buttonColors[index]}}
                                            onClick={() => handleChangeVisible(index)}/>
                                    {isPickerOpen[index] && (
                                        <SketchPicker
                                            color={buttonColors[index]}
                                            className={styles.sketchPicker}
                                            onChange={(color) => handleChangeSketchPicker(color, index)}
                                        />
                                    )}
                                </Space>
                            </div>

                        </List.Item>
                    )}
                />
                <Button type={"link"} className={styles.addSchedule} onClick={handleModalOpen}>일정 추가하기</Button>
                <Button type={"default"} className={styles.saveButton} onClick={handleSave}>저장하기</Button>
                {isModalOpen && (
                    <Modal
                        title={'카테고리 추가'}
                        open={isModalOpen} // 수정: open prop을 visible prop으로 변경
                        onOk={handleOk}
                        onCancel={handleCancel}
                        centered={true}
                    >
                        <p>카테고리 종류</p>
                        <Input value={categoryValue} onChange={e => setCategoryValue(e.target.value)}/>
                        <p>색상</p>
                        <Space>
                            <Button type={"default"}/>
                            <SketchPicker
                                color={buttonColors[0]} // 기본 색상 설정
                                onChange={(color) => setButtonColors([color.hex])} // 색상 선택시 색상 변경
                                className={styles.sketchPicker} // 스타일 적용
                            />
                        </Space>
                    </Modal>
                )}
            </div>
        </div>
    );
}
