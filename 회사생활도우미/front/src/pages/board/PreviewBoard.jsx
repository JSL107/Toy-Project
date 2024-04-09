import {List} from "antd";
import styles from './PreviewBoard.module.css';

export function PreviewBoard() {
    return (

        <List>
            <List.Item><p className={styles.boardItem}>[공지] 공지 게시글 입니다.</p></List.Item>
            <List.Item><p className={styles.boardItem}>[공지] 공지 게시글 입니다.</p></List.Item>
        </List>

    )
}
