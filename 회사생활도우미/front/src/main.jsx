import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './index.css';
import {createBrowserRouter, RouterProvider} from 'react-router-dom';
import {Login} from "./components/user/Login.jsx";
import SignUp from "./components/user/SignUp.jsx";

const router = createBrowserRouter([
    {path: '/', element: <App/>},
    {path: '/login', element: <Login/>},
    {path: '/sign-up', element: <SignUp/>}
]);

ReactDOM.createRoot(document.getElementById('root')).render(
    <React.StrictMode>
        <RouterProvider router={router}/>
    </React.StrictMode>,
)
