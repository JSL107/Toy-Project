const requests = {
    // https://api. ~~ 이런게 빠져있는 상태
    fetchNeflixOriginals: `/discover/tv?api_key=${API_KEY}& with_networks=213`,
    fetchTrending: `/trending/all/week?api_key=${API_KEY}&language=ko`,
    fetchTopRated: `/movie/top_rated?api_key=${API_KEY}&language=ko`,
    fetchActionMovies: `/discover/movie?api_key=${API_KEY}&with_genres=28`,
    fetchComedyMovies: `/discover/movie?api_key=${API_KEY}&with_genres=35`,
    fetchHorrorMovies: `/discover/movie?api_key=${API_KEY}&with_genres=27`,
    fetchRomanceMovies: `/discover/movie?api_key=${API_KEY}&with_genres=10749`,
    fetchDocumentaries: `/discover/movie?api_key=${API_KEY}&with_genres=99`,
}

export default requests;
