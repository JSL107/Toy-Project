import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App.jsx'
import './index.css';
import {createBrowserRouter, RouterProvider} from 'react-router-dom';
import {Login} from "./pages/user/Login.jsx";
import SignUp from "./pages/user/SignUp.jsx";
import MyPage from "./pages/user/MyPage.jsx";

const router = createBrowserRouter([
    {path: '/', element: <App/>},
    {
        path: '/user', children: [
            {path: 'login', element: <Login/>},
            {path: 'sign-up', element: <SignUp/>},
            {path: 'my-page', element: <MyPage/>}
        ]
    }
]);

ReactDOM.createRoot(document.getElementById('root')).render(
    <React.StrictMode>
        <RouterProvider router={router}/>
    </React.StrictMode>,
)
