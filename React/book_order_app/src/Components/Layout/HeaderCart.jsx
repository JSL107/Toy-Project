import React from "react";
import classes from './HeaderCart.module.css';
import CartIcon from '../Cart/CartIcon';

const HeaderCart = (props) => {
  return (
    <button className={classes.button} onClick={props.onOpen}>
      <span className={classes.icon}><CartIcon /></span>      
      <span>My Cart</span>
    </button>
  );
};

export default HeaderCart;
