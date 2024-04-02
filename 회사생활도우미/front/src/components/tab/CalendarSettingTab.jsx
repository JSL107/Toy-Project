import {Form, Select, Typography} from "antd";
import styles from "../../pages/user/MyPage.module.css";
import {useState} from "react";

const {Title} = Typography;
const {Option} = Select;

export function CalendarSettingTab() {
    const [scheduleColor, setScheduleColor] = useState('');


    const handleScheduleColorChange = (color) => {
        setScheduleColor(color);
    };

    return (
        <div>
            <Title level={3}>일정 관리</Title>
            <Form className={styles.form}>
                <Form.Item label="일정 카테고리 색상 선택">
                    <Select onChange={handleScheduleColorChange} value={scheduleColor}>
                        <Option value="blue">파란색</Option>
                        <Option value="green">초록색</Option>
                        <Option value="red">빨간색</Option>
                        {/* 추가 색상 옵션들 */}
                    </Select>
                </Form.Item>
                {/* 일정 추가, 수정, 삭제 기능 구현 */}
            </Form>
        </div>
    )
}
