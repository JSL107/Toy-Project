import React from "react";
import classes from "./CartItem.module.css";

const CartItem = (props) => {
  const price = `$${props.price.toFixed(2)}`

  return (
    <li className={classes["cart-item"]}>
      <h2>{props.name}</h2>
      <div className={classes.summary}>
        <span className={classes.price}>{price}</span>
        <span className={classes.amount}>x {props.amount}</span>
      </div>
      <div className={classes.buttons}>
        <button onClick={props.onRemoveInCart}>x</button>
      </div>
    </li>
  );
};

export default CartItem;
