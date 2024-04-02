import {Button, notification, Typography} from "antd";

export function DeleteUserTab() {
    const {Title} = Typography;
    const handleDeleteAccount = () => {
        notification.success({
            message: '계정이 삭제되었습니다.',
        });
    };
    return (
        <div>
            <Title level={3}>계정 삭제</Title>
            <Button type="danger" onClick={handleDeleteAccount}>계정 삭제</Button>
        </div>
    )
}
