import { useState, useEffect } from 'react';
import requests from '../requests';
import './Banner.css';

// axios.js 모듈을 import 하는 구문
import axios from '../axios';

const Banner = () => {
    const [movie, setMovie] = useState([]); // 초기값 : 빈 배열

    // useEffect() hook
    useEffect(() => {
        // 화면이 초기에 랜더링된 직후 한 번 호출.

        // API 서버에 데이터 요청하는 부분.
        // async, await
        async function fetchData() {
            // axios : instance
            // 비동기요청으로 받아온 응답데이터
            const request = await axios.get(requests.fetchNeflixOriginals);
            // console.log(request);

            // 새로 고침 마다 랜덤으로 사진이 바뀌는 코드
            const randomMovie = request.data.results[
                Math.floor(Math.random() * request.data.results.length - 1)
              ];
            setMovie(randomMovie);
        }

        fetchData();
         
     },[]);

     
    //  console.log(movie);
    //  어느 정도 코드 길이가 되면 잘라라
     function truncate(str, n) {
        return str?.length > n ? str.substr(0, n - 1) + "..." : str;
      }
     
    return (
        <header className='banner' style={{
            backgroundSize: "cover",
            // backgroundImage: `url(tmdb api 주소)`,
            backgroundImage: `url(https://image.tmdb.org/t/p/original/${movie.backdrop_path})`,
            backgroundPosition:"center center"
        }}>
            {/* Background image */}
            <div className="banner__contents">
                {/*movie?.title : optional chainning : 오류가 나도 끊기지만 마라 */}
                <h1 className="banner_title">{movie?.title || movie?.name || movie?.original_name}</h1>

                {/* div banner__buttons> div.banner__button*2 */}
                <div className="banner__buttons">
                    <button className="banner__button">Play</button>
                    <button className="banner__button">My List</button>
                </div>

                {/* description */}
                <h1 className="banner__description">
                    {truncate(movie?.overview,150)}
                </h1>
            </div>

            {/* 배너 맨 밑줄 어두운 선 생기는 css 적용 */}
           <div className="banner--fadeBottom"></div>
        </header>
    )
}

export default Banner