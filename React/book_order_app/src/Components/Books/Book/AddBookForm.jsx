import React, { useRef, useState } from 'react';
import Input from '../../Commons/Input';
import Button from '../../Commons/Button';
import classes from './AddBookForm.module.css';
import _uniqueId from 'lodash/uniqueId'

const AddBookForm = (props) => {
  const [id] = useState(_uniqueId('prefix-'));
  // label id key generator : https://stackoverflow.com/questions/29420835/how-to-generate-unique-ids-for-form-labels-in-react

  const inputRef = useRef();
  // console.log(inputRef);

  const submitHandler = (event) => {
    event.preventDefault();
    // console.log(event.target.value);
    const amountValue = inputRef.current.value;
    // console.log(amountValue);
    // console.log(typeof amountValue);

    const amountValueToNumber = +amountValue;
    // console.log(typeof amountValueToNumber);
    
    props.onAddToCart(amountValueToNumber);
  }

  return <form className={classes.form}>
    <Input label={'Amount'} 
    ref={inputRef}
    input={{
        id: id,
        type: 'number',
        defaultValue: '1',
    }}/>
    <Button type="submit" onClick={submitHandler}>Add</Button>
  </form>
};

export default AddBookForm;
