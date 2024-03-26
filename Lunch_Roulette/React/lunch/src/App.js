import './App.css';
import {Routes, Route, BrowserRouter} from 'react-router-dom';
import Main from './pages/Main/Main'
import Roulette from './pages/Roulette/Roulette'
import Header from "./components/header";
import Footer from "./components/footer";

function App() {
    return (
        <div className="App">
            <header className="App-header">
                <BrowserRouter basename={process.env.PUBLIC_URL}>
                    <Header/>
                    <Routes>
                        <Route path="/" element={<Main/>}/>
                        <Route path="/roulette" element={<Roulette/>}/>
                    </Routes>
                    <Footer/>
                </BrowserRouter>
            </header>
        </div>
    );
}

export default App;
