import {isValidDate, isValidEmail, isValidID, isValidPassword, isValidUsername} from "../regex/UserRegex.js";

export const validateFormData = (data) => {
    let errors = {};
    Object.keys(data).forEach((key) => {
        if (!data[key]) {
            errors[key] = '필수 입력 항목입니다.';
        } else if (key === 'email' && !isValidEmail(data[key])) {
            errors[key] = '올바른 이메일 주소를 입력하세요.';
        } else if (key === 'birthday' && !isValidDate(data[key])) {
            errors[key] = '올바른 생년월일 형식을 입력하세요.';
        } else if (key === 'id' && !isValidID(data[key])) {
            errors[key] = '숫자와 영어로만 이루어진 2자 이상의 ID를 입력하세요.';
        } else if (key === 'username' && !isValidUsername(data[key])) {
            errors[key] = '영어 또는 한글로만 이루어진 사용자명을 입력하세요.';
        } else if (key === 'password' && !isValidPassword(data[key])) {
            errors[key] = '비밀번호는 8자 이상의 영문, 숫자, 특수문자를 포함해야 합니다.';
        }
    });
    return errors;
};
