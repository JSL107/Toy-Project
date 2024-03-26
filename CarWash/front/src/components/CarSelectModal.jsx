import React from 'react'
import '../styles/components/carSelectModal.css'

function CarSelectModal({onClose, isShow}) {

    return (
        <div className={`modal ${isShow ? 'open' : ''}`}>
            <div className="reservation_modal">
                <div className="modal-header">
                    <h3 className="modal-title">차 종류를 선택하여주세요.</h3>
                    <span className="close" onClick={onClose}>&times;</span>
                </div>
                <div className="modal-body">
                    <div className="brand_list">

                    </div>
                    <div className="car_list">

                    </div>
                </div>
            </div>
        </div>
    )
}

export default CarSelectModal