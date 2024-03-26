import React, { useState } from "react";
import CartContext from "./CartContext";

const CartProvider = (props) => {
  const [cartState, setCartState] = useState({
    // items: [{id: 'book1', name: 'THE OLD MAN AND SEA', price: 15.23, amount: 5}],
    // totalAmount: 76.15
    items: [],
    totalAmount: 0
  });

  const addItemToCartHandler = (item) => {

    // 1. 기본으로 add할 경우,
    // const updatedItem = [
    //   ...cartState.items,
    //   item
    // ]
    // console.log(updatedItem);

    // 2. Add를 1개씩 여러 번 추가하였을 때 카트에 각각 리스팅되지않고, 중복된 수량으로 연산
    // 이미 동일한 id값의 book이 있으면, 해당 book의 amount만 추가.
    const existingCartItemIndex = cartState.items.findIndex(
      (cartItem) => cartItem.id === item.id
    );
    const existingCartItem = cartState.items[existingCartItemIndex];

    let updatedItems;
    if(existingCartItem) {
      const updatedItem = {
        ...existingCartItem,
        amount: existingCartItem.amount + item.amount,
      };
      updatedItems = [...cartState.items];
      updatedItems[existingCartItemIndex] = updatedItem;
    } else {
      updatedItems = cartState.items.concat(item);
    }

    const updatedTotalAmount = cartState.totalAmount + item.price * item.amount;

    setCartState({items: updatedItems, totalAmount: updatedTotalAmount});
  };

  const removeItemToCartHandler = (id) => {
    const selectedCartItemIndex = cartState.items.findIndex(
      (item) => item.id === id
    );
    console.log(selectedCartItemIndex);

    const selectedCartItem = cartState.items[selectedCartItemIndex];
  
    const updatedTotalAmount = cartState.totalAmount - selectedCartItem.amount * selectedCartItem.price;
    // console.log(updatedTotalAmount);

    // 배열에서 해당 객체만 제거 후 다시 업데이트
    const updatedItems = cartState.items.filter(item => item.id !== id);

    setCartState({items: updatedItems, totalAmount: updatedTotalAmount});
  };
  
  const cartContext = {
    items: cartState.items,
    totalAmount: cartState.totalAmount,
    addItem: addItemToCartHandler,
    removeItem: removeItemToCartHandler,
}

  return <CartContext.Provider value={cartContext}>{props.children}</CartContext.Provider>;
};

export default CartProvider;
