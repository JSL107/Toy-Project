import {Modal} from "antd";
import PropTypes from "prop-types";

ConfirmOrCanCelModal.propTypes = {
    title: PropTypes.string.isRequired,
    modalText: PropTypes.string,
    isVisible: PropTypes.bool.isRequired,
    setIsVisible: PropTypes.func.isRequired,
};

export function ConfirmOrCanCelModal(props) {
    const {title, modalText, isVisible, setIsVisible} = props;

    const handleOk = () => {
        setIsVisible(false);

    };

    const handleCancel = () => {
        setIsVisible(false);
    };

    return (
        <Modal
            title={title}
            open={isVisible} // 수정: visible prop을 isVisible prop으로 변경
            onOk={handleOk}
            onCancel={handleCancel}
            centered={true}
        >
            {modalText}
        </Modal>
    );
}
