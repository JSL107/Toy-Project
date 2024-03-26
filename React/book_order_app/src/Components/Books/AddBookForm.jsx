import React, { useState, useRef } from 'react'
import Button from '../Commons/Button'
import Input from '../Commons/Input'
import classes from './AddBookForm.module.css'

// 고유한 ID만들어주는 내장 함수
import _uniqueId from 'lodash/uniqueId';

const AddBookForm = (props) => {
    const [id] = useState(_uniqueId('prefix-'));

    const inputRef = useRef();

    const submitHandler = (event) => {

        // 기본개념을 막을때 쓰는 코드
        event.preventDefault();

        // console.log('submitHandler called');
        // console.log(event.target.value); 

        // 숫자로 변환해주는 코드들
        // const amountValue = parseInt(inputRef.current.value);
        // const amountValue = +amountValue;        
        const amountValue = parseInt(inputRef.current.value);

        //숫자가 맞는지 확인
        // console.log(amountValue);

        props.onAddToCart(amountValue);
    };

    return (
        // form 태그는 서버로 보내는 request 요청을 가지고있음
        <form className={classes.form}>
            {/* 객체만들기 : {{}}*/}
            {/* input={{ id: 'amount', type: 'number', defaultValue: '1' }} : 객체를 Input.jsx로 내려보냄*/}
            <Input ref={inputRef} label={'Amount'} input={{ id: id, type: 'number', defaultValue: '1' }} />
            {/*button의 타입은 submit이고, onClick이벤트 발생시, 핸들러 함수는 submitHandler
           button의 Content는 Add*/}

            {/* default로 button이 선언되어 있음 */}
            {/* type='submit' : 해두면 실제 요청을 하는 행위를 함  */}
            <Button type='submit' onClick={submitHandler}>Add</Button>
        </form>
    )
}

export default AddBookForm