// 실제 설치한 axios 라이브러리를 import 하는 코드.
import axios from 'axios';

const instance = axios.create({
    // tmdb api url
    baseURL: 'https://api.themoviedb.org/3',
});

export default instance;

// https://api.the~~~ 앞단에 등록

// if instance.get('/discover/tv?api_key ~~)