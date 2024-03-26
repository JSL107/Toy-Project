import React from "react";
import classes from "./Header.module.css";
// import booksImage from "../../assets/books.jpg";
import HeaderCart from "./HeaderCart";

const Header = (props) => {
  return (
    <>
      <header className={classes.header}>
        <h1>Book Order app</h1>
        <HeaderCart onOpen={props.onOpen}/>
      </header>
      {/* <div className={classes["header-image"]}>
        <img src={booksImage} alt="A bookstore" />
      </div> */}
    </>
  );
};

export default Header;
