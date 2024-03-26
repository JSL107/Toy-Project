const textAreaArray = document.querySelectorAll('textarea');
console.log(textAreaArray);

// 변수 네이밍 컨벤션, 도메인과 관련된 용어 정의

// source : 번역할 텍스트와 관련된 명칭
// target : 번역된 결과와 관련된 명칭

const [sourceTextArea, targetTextArea] = textAreaArray;
// console.log(sourceTextArea);
// console.log(targetTextArea);

const [sourceSelect, targetSelect] = document.querySelectorAll('select');

// 번역할 언어의 타입( ko?, en?, ja? )
let targetLanguage = 'en';
// 'ko', 'ja'

// 어떤 언어로 번역할지 선택하는 target selectbox의 선택지 값이 바뀔 때마다 이벤트 발생.
targetSelect.addEventListener('change', () => {
    const selectedIndex = targetSelect.selectedIndex;
    targetLanguage = targetSelect.options[selectedIndex].value;
});

let debouncer;
// 값이 있으면 true, 없으면 false
// 입력이 지속되면 계속 초기화 되면서 3초가 흘러가지 않음


sourceTextArea.addEventListener('input', (event) => {

    if (debouncer) {
        clearTimeout(debouncer);
    }
    // textArea에 입력한 값
    debouncer = setTimeout(() => { 
        // textArea에 입력한 값

        
        const text = event.target.value;

        if(text){
        // 이름이 XML일뿐이지, XML에 국한되지 않음.
        // 얘 떄문에 비동기로 진행
        // 회원가입같은건 동기로 진행
        const xhr = new XMLHttpRequest();

        // node 서버의 특정 url 주소
        const url = '/detectLangs';

        xhr.onreadystatechange = () => {
            if (xhr.readyState == 4 & xhr.status == 200) {

                // 서버의 응답 결과 확인(responseText : 응답에 포함된 텍스트)
                // console.log(typeof xhr.responseText);
                const responseData = xhr.responseText;
                // console.log(`responseData : ${responseData}, type : ${typeof responseData}`);
                const parseJsonToObject = JSON.parse(JSON.parse(responseData));

                console.log(typeof parseJsonToObject, parseJsonToObject);

                const result = parseJsonToObject['message']['result'];

                const options = sourceSelect.options;

                for(let i =0; i <options.length; i++){
                    if(options[i].value === result['srcLangType']){
                        sourceSelect.selectedIndex = i;
                    }

                }
                //번역된 결과 텍스트를 결과화면에 입력
                targetTextArea.value = result['translatedText'];


                //응답의 헤더(header) 확인
                // console.log(`응답 헤더 : ${xhr.getAllResponseHeaders()}`);
            }
        };

        // xhr.addEventListener('load', () => {
        //     if (xhr.status == 200){

        //     }
        // });

        xhr.open("POST", url);

        // 컨텐츠타입을 지정해주는 문구, 서버에 보내는 요청 데이터의 형식이 json형식임을 명시.
        xhr.setRequestHeader("Content-type", "application/json")

        const requestData = {
            text,
            targetLanguage
        };
        // Json(Javascript Object notation)의 타입은? String
        // 내장 모듈 JSON 활용 ['a','b','c']
        // 서버에 보낼 데이터를 문자열화 시킴
        jsonToString = JSON.stringify(requestData);
        // console.log(typeof jsonToString);

        //xhr : XMLHttpRequest
        // 우리가 보낼껀 jsonToString
        xhr.send(jsonToString);
    } else {
        console.log("번역할 텍스트를 입력하세요");
    }
    }, 3000);
});