import ReactDOM from "react-dom/client";
import App from "./App";
import axios from "axios";
import 'bootstrap/dist/css/bootstrap.css';

axios.defaults.withCredentials = true;
const root = ReactDOM.createRoot(
    document.getElementById("root") as HTMLElement
);
root.render(<App/>);