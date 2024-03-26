import './App.css';
import Nav from './Components/Nav'
import Banner from './Components/Banner';
import Row from './Components/Row';
import requests from './requests';

function App() {

  return (
    <div className="App">
      {/* Nav */}
      <Nav />

      {/* Banner */}
      <Banner />

      {/* Row */}
      {/* isLargeRow : 아무것도 쓰지 않으면 true 가 기본값 */}
      <Row title={'Netflix Originals'} fetchUrl={requests.fetchNeflixOriginals} isLargeRow/>
      <Row title="Trending Now" fetchUrl={requests.fetchTrending} />
      <Row title="Top Rated" fetchUrl={requests.fetchTopRated} />
      <Row title="Action Movies" fetchUrl={requests.fetchActionMovies} />
      <Row title="Comedy Movies" fetchUrl={requests.fetchComedyMovies} />
      <Row title="Horror Movies" fetchUrl={requests.fetchHorrorMovies} />
      <Row title="Romance Movies" fetchUrl={requests.fetchRomanceMovies} />
      <Row title="Documentaries" fetchUrl={requests.fetchDocumentaries} />
    </div>
  )
}

export default App;
