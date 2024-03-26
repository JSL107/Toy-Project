import React, { useRef } from "react";
import classes from "./BookOrder.module.css";
import Input from "../Commons/Input";
import Button from "../Commons/Button";

const BookOrder = (props) => {
  const nameInputRef = useRef();
  const addrInputRef = useRef();
  // const postalInputRef = useRef();

  const chargeHandler = event => {
    event.preventDefault();

    const enteredName = nameInputRef.current.value;
    const enteredAddress = addrInputRef.current.value;
    // const enteredPostal = postalInputRef.current.value
    
    props.onOrder({
      userName: enteredName,
      address: enteredAddress,
      // postal: enteredPostal,
    });

  }

  return (
    <form className={classes.form}>
      <Input ref={nameInputRef} label="name" input={{ id: "name", type: "text" }} />
      <Input ref={addrInputRef} label="address" input={{ id: "address", type: "text" }} />
      {/* <Input ref={postalInputRef} label="postal" input={{ id: "postal", type: "text" }} /> */}
      <Button type="submit" onClick={chargeHandler}>Charge</Button>
    </form>
  );
};

export default BookOrder;
