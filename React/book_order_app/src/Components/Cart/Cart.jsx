import React, { useContext, useState } from "react";
import Modal from "../Commons/Modal";
import classes from "./Cart.module.css";
import CartItem from "./CartItem";
import Button from "../Commons/Button";
import CartContext from "../../store/CartContext";
import BookOrder from "../Books/BookOrder";

// const BOOKS = [
//   {
//     id: "book1",
//     name: "THE OLD MAN AND THE SEA",
//     description:
//       "A story of Santiago, an aging Cuban fisherman who struggles with a giant marlin far out in the Gulf Stream off the coast of Cuba",
//     author: "Ernest Hemingway",
//     price: 10.57,
//   },
//   {
//     id: "book2",
//     name: "THE GREAT GATSBY",
//     description:
//       "Set in the Jazz Age on Long Island, near New York City, the novel depicts first-person narrator Nick Carraway's interactions with mysterious millionaire Jay Gatsby and Gatsby's obsession to reunite with his former lover, Daisy Buchanan.",
//     author: "F.Scott Fitzgerald",
//     price: 12.97,
//   },
// ];

const BASE_URL = 'http://localhost:8090/api/v1/orders';

const Cart = (props) => {
  // ContextAPI 적용 전,
  // const [books, setBooks] = useState(BOOKS);

  // ContextAPI 적용 후,
  const cartContext = useContext(CartContext);
  // console.log(cartContext);

  // Submit 결과 메시지 확인용 Toggle
  const [didSubmit, setDidSubmit] = useState(false);

  const removeItemInCartHandler = (id) => {
    cartContext.removeItem(id);
  };

  const totalAmount = `$${cartContext.totalAmount.toFixed(2)}`;

  const cartItems = (
    <ul className={classes["cart-items"]}>
      {cartContext.items.map((book) => (
        <CartItem
          key={book.id}
          id={book.id}
          name={book.name}
          price={book.price}
          amount={book.amount}
          onRemoveInCart={removeItemInCartHandler.bind(null, book.id)}
        />
      ))}
    </ul>
  );

  const cartItemsTotal = (
    <div className={classes.total}>
      <span>Total Amount</span>
      <span>{totalAmount}</span>
    </div>
  );

  const modalButton = (
    <div className={classes.buttons}>
      <Button onClick={props.onClose}>Close</Button>
      <Button>Order</Button>
    </div>
  );

  const cartOrderHandler = async (userData) => {
    console.log('dd',userData);
    // post 처리
    console.log(typeof cartContext.totalAmount);
    console.log(cartContext.items[0].name);

    console.log(JSON.stringify({
      userName: userData.userName,
      address: userData.address,
      bookTitle : cartContext.items[0].name,
      totalPrice : cartContext.totalAmount,
      // bookDto: cartContext.items[0]
    }));

    // let params = {
    //   userName: userData.userName,
    //   address: userData.address,
    //   bookTitle : cartContext.items[0].name,
    //   totalPrice : cartContext.totalAmount,
    // };

    await fetch(BASE_URL,
      {
        method: 'POST',
        headers: {
          'Content-Type' : 'application/json',
        },
        body: JSON.stringify({
          userName: userData.userName,
          address: userData.address,
          bookTitle : cartContext.items[0].name,
          totalPrice : cartContext.totalAmount,
        })
      }
    );

    setDidSubmit(true);
  }

  const cartModalContent = (
    <>
      {cartItems}
      {cartItemsTotal}
      {modalButton}
      <BookOrder onOrder={cartOrderHandler}/>
    </>
  );

  const didSubmitModalContent = (
    <>
      <p>Successfully ordered!</p>
      <Button className={classes['order-close']} onClick={props.onClose}>Close</Button>
    </>
  );

  return <Modal onClose={props.onClose}>{!didSubmit ? cartModalContent : didSubmitModalContent}</Modal>;
};

export default Cart;
