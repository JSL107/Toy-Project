import styles from './WeatherWidget.module.css';
import {useEffect, useState} from "react";
import axios from "axios";

export const WeatherWidget = () => {
    const [state, setState] = useState({icon: '', temp: '', uv: '', maxtemp: '', mintemp: '', state: ''});

    useEffect(()=> {
        response();
    }, [])
    const response = () => {
        axios.get('http://api.weatherapi.com/v1/forecast.json', {
            params: {
                key: import.meta.env.VITE_OPEN_WEATHER_API,
                q: '37.550552, 126.9160743',
                days: '',
                lang: 'ko'
            }
        }).then((res) => {
            setState({
                icon: `https://${res.data.current.condition.icon}`,
                temp: res.data.current.temp_c,
                uv: res.data.current.uv,
                maxtemp: res.data.forecast.forecastday[0].day.maxtemp_c,
                mintemp: res.data.forecast.forecastday[0].day.mintemp_c,
                state: res.data.current.condition.text,
            })
        })

    }
    return (
        <div className={styles.weatherInfo}>
            <div className={styles.iconSection}>
                <img src={state.icon} alt={''}/>
            </div>

            <div className={styles.tempSection}>
                <h1>{state.temp}</h1>
                <p>{state.maxtemp}/{state.mintemp}</p>
            </div>
            <div className={styles.infomationSection}>
                <div className={styles.stateSection}>
                    <h3>{state.state}</h3>
                </div>
                <div className={styles.additionalInfoSectionDust}>
                    <p>미세먼지 : 나쁨</p>
                </div>
                <div className={styles.additionalInfoSectionUV}>
                    <p>자외선 {state.uv}</p>
                </div>

                <div className={styles.locationSection}>
                    <p>내위치:</p>
                    <p>서울시 도곡동</p>
                </div>
            </div>
        </div>
    )
}
