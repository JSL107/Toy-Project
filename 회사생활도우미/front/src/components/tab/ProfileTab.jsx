import {Button, Form, DatePicker, notification, Typography, Input, Space, Modal} from "antd";
import {MailOutlined, PhoneOutlined, UserOutlined} from "@ant-design/icons";
import {useEffect, useState} from "react";
import styles from './Profile.module.css';
import {validateFormData} from "../../utils/function/UserValidCheck.js";
import {ConfirmOrCanCelModal} from "../modal/ConfirmOrCancelModal.jsx";

const {Title} = Typography;

export function ProfileTab() {
    const [profileFormData, setProfileFormData] = useState({
        username: '',
        birthday: '',
        contact: '',
        email: ''
    });

    const modalInfo = {
        description: '탈퇴는 한 달 후에 이루어지며 로그인 시 회원을 복구할 수 있습니다.',
        message: '계정이 삭제되었습니다.',
        title: '탈퇴',
        modalText: '정말 삭제하시겠습니까?'
    };

    const [isVisible, setIsVisible] = useState(false);

    const handleSaveProfile = () => {
        const errors = validateFormData(profileFormData);

        if (errors !== '') {
            notification.error({
                message: '프로필 저장에 실패하였습니다.'
            })
        } else {
            notification.success({
                message: '프로필 정보가 저장되었습니다.',
            });
        }
    };

    const handleProfileFormChange = (value, name) => {
        setProfileFormData({...profileFormData, [name]: value});
    };

    const onChange = (date, dateString) => {
        setProfileFormData({...profileFormData, birthday: dateString});
    };

    const handleDeleteAccount = () => {
        setIsVisible(true);

        //TODO :: 탈퇴가 완료 되었을때 출력될 수 있는 코드 작성
        notification.info({
            message: modalInfo.message,
            description: modalInfo.description,
        });

    };
    console.log(isVisible);

    return (
        <div className={styles.profileSection}>
            <Title level={1} className={styles.title}>프로필 정보 수정</Title>
            <Form className={styles.form}>
                <Form.Item label="사용자명">
                    <Input prefix={<UserOutlined/>} value={profileFormData.username}
                           onChange={(e) => handleProfileFormChange(e.target.value, 'username')}
                           className={styles.input}/>
                </Form.Item>
                <Form.Item label={"생년월일"}>
                    <DatePicker
                        format={{
                            format: 'YYYY-MM-DD',
                            type: 'mask',
                        }}
                        placeholder="생년월일 (YYYY-MM-DD)"
                        className={styles.input}
                        onChange={onChange}
                    />
                </Form.Item>
                <Form.Item label="연락처">
                    <Input prefix={<PhoneOutlined/>} value={profileFormData.contact}
                           onChange={(e) => handleProfileFormChange(e.target.value, 'contact')}
                           className={styles.input}/>
                </Form.Item>
                <div className={styles.emailSection}>
                    <Form.Item label="이메일" className={styles.email}>
                        <Space.Compact style={{width: '100%'}}>
                            <Input prefix={<MailOutlined/>} value={profileFormData.email}
                                   onChange={(e) => handleProfileFormChange(e.target.value, 'email')}
                                   className={styles.input}/>
                            <Button type={"default"} className={styles.emailCheckButton}>인증 하기</Button>
                        </Space.Compact>
                    </Form.Item>
                </div>
                <Button type="default" onClick={handleSaveProfile} className={styles.button}>저장</Button>
                <Button type={"link"} className={styles.deleteUser} onClick={handleDeleteAccount}>회원 탈퇴하기</Button>
                {isVisible && (
                    <ConfirmOrCanCelModal
                        title={modalInfo.title}
                        message={modalInfo.message}
                        description={modalInfo.description}
                        setIsVisible={setIsVisible}
                        isVisible={isVisible}
                        modalText={modalInfo.modalText}
                    />
                )}
            </Form>
        </div>
    )
}
