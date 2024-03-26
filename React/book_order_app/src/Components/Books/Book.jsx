import React, { useContext } from 'react'
import CartContext from '../../store/CartContext'
import AddBookForm from './AddBookForm'
import classes from './Book.module.css'

const Book = (props) => {
  const cartContext = useContext(CartContext);
  const addItemToCartHandler = (amount) => {

    // console.log(amount);

    // book 객체 생성
    const book = {
      id: props.id,
      name: props.name,
      amount: amount,
      price: props.price,
    };

    // 중앙저장소로 올려보냄
    cartContext.addItem(book);
  };

  return (
    <li className={classes.book}>
      <div className={classes.book__info}>
        <h3>{props.name} - <span className={classes.author}>{props.author}</span></h3>
        <div className={classes.description}>{props.description}</div>
        <div className={classes.price}>{props.price}</div>
      </div>
      <AddBookForm onAddToCart={addItemToCartHandler} />
    </li>

  )
}

export default Book