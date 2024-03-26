import React, { useContext } from "react";
import classes from './Book.module.css';
import AddBookForm from "./AddBookForm";
import CartContext from "../../../store/CartContext";

const Book = (props) => {
  const cartContext = useContext(CartContext);

  const addItemToCartHandler = amount => {
    // console.log(amount);
    cartContext.addItem({
      id: props.id,
      name: props.name,
      amount: amount,
      price: props.price
    })
  }

  return (
    <li className={classes.book}>
      <div className={classes.book__info}>
        <h3>{props.name} - <span className={classes.author}>{props.author}</span></h3>
        <div className={classes.description}>{props.description}</div>
        <div className={classes.price}>${props.price}</div>
      </div>
      <AddBookForm onAddToCart={addItemToCartHandler}/>
    </li>
  );
};

export default Book;
