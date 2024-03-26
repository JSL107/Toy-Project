import Header from "./components/Layout/Header";
import Main from "./components/Layout/Main";
import Books from "./components/Books/Books";
import Cart from "./components/Cart/Cart";
import { useState } from "react";
import CartProvider from "./store/CartProvider";

function App() {
  const [cartIsShown, setCartIsShown] = useState(false);

  const closeCartHandler = () => {
    setCartIsShown(false);
  }

  const openCartHandler = () => {
    setCartIsShown(true);
  }

  return (
    <CartProvider>
      {cartIsShown && <Cart onClose={closeCartHandler}/>}
      <Header onOpen={openCartHandler}/>
      <Main>
        <Books />
      </Main>
    </CartProvider>
  );
}

export default App;
