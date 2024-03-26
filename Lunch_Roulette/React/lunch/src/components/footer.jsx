import '../styles/footer.css'

const Footer = () => {
    return (
        <footer className="footer">
            <div className="Footer_Author">
                <p className="title">제작자</p>
                <p className="author">이준석</p>
            </div>
            <div className="Footer_Content">
                <p className="title">추가 개발문의</p>
                <p className="email">EMAIL : juneseok0107@naver.com</p>
                <p className="version">VER : 1.0</p>
            </div>
        </footer>
    )
}

export default Footer