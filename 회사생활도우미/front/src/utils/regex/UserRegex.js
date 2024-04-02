// 이메일 유효성 검사
export const isValidEmail = (email) => {
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return emailRegex.test(email);
};

// 생년월일 유효성 검사
export const isValidDate = (date) => {
    const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
    return dateRegex.test(date);
};


// ID 유효성 검사
export const isValidID = (id) => {
    const idRegex = /^[a-zA-Z0-9]{2,}$/;
    return idRegex.test(id);
};

// 사용자명 유효성 검사
export const isValidUsername = (username) => {
    const usernameRegex = /^[a-zA-Z가-힣]+$/;
    return usernameRegex.test(username);
};


// 비밀번호 유효성 검사
export const isValidPassword = (password) => {
    const passwordRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,}$/;
    return passwordRegex.test(password);
};
