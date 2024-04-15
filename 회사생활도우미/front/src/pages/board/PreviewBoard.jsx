import {List, Typography} from "antd";
import styles from './PreviewBoard.module.css';

const {Title} = Typography;

export function PreviewBoard() {
    return (
        <>
            <Title level={3} className={styles.title}>게시글</Title>
            
            <List>
                <List.Item><p className={styles.boardItem}>[공지] 공지 게시글 입니다.</p></List.Item>
                <List.Item><p className={styles.boardItem}>[공지] 공지 게시글 입니다.</p></List.Item>
            </List>
        </>

    )
}
