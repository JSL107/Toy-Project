import {useState} from "react";
import {Typography, Input, Button, Space, List, Checkbox, message, notification} from "antd";
import EditIcon from "@mui/icons-material/Edit";
import DeleteIcon from "@mui/icons-material/Delete";
import SaveIcon from "@mui/icons-material/Save";
import styles from './TODOList.module.css';

const {Title} = Typography;

export function TODOList() {
    const [isEditing, setIsEditing] = useState(false);
    const [todoList, setTodoList] = useState([]);
    const [editingCheckedItems, setEditingCheckedItems] = useState([]);
    const [editingTodoList, setEditingTodoList] = useState([]);

    const toggleEditMode = () => {
        if (isEditing) {
            // 수정 모드에서 취소 버튼을 누를 때 변경사항을 적용하지 않고 이전 상태로 돌아갑니다.
            setEditingCheckedItems([]);
            setEditingTodoList([]);
        } else {
            // 수정 모드로 진입할 때 현재 상태를 저장합니다.
            setEditingTodoList([...todoList]);
        }
        setIsEditing(!isEditing);
    };

    const handleAddTODO = () => {
        setEditingTodoList([...editingTodoList, {content: "", checked: false}]);
    };

    const handleTodoContentChange = (index, value) => {
        const updatedTodoList = [...editingTodoList];
        updatedTodoList[index].content = value;
        setEditingTodoList(updatedTodoList);
    };

    const handleDeleteCheckedItems = () => {
        const updatedTodoList = editingTodoList.filter(
            (_, index) => !editingCheckedItems.includes(index)
        );
        setEditingTodoList(updatedTodoList);
        setEditingCheckedItems([]);
    };

    const handleToggleCheckedItem = (index) => {
        if (isEditing) {
            const updatedCheckedItems = [...editingCheckedItems];
            if (updatedCheckedItems.includes(index)) {
                const indexToRemove = updatedCheckedItems.indexOf(index);
                updatedCheckedItems.splice(indexToRemove, 1);
            } else {
                updatedCheckedItems.push(index);
            }
            setEditingCheckedItems(updatedCheckedItems);
        } else {
            const updatedTodoList = [...todoList];
            updatedTodoList[index].checked = !updatedTodoList[index].checked;
            setTodoList(updatedTodoList);
            // 모든 일정이 완료되었는지 확인
            const allChecked = updatedTodoList.every(todo => todo.checked);
            if (allChecked) {
                message.success('모든일정을 완료하였습니다.', 10)
            }
        }

    };

    const handleSaveChanges = () => {
        setTodoList([...editingTodoList]);
        setIsEditing(false);
    };

    return (
        <div>
            <Space className={styles.header}>
                <Title level={2} className={styles.title}>
                    오늘 할일
                </Title>
                {isEditing ? (
                    <Space className={styles.headerButtonSection}>
                        <Button onClick={handleSaveChanges} className={styles.saveButton} icon={<SaveIcon/>}/>
                        <Button
                            onClick={handleDeleteCheckedItems}
                            icon={<DeleteIcon/>}
                            disabled={!editingCheckedItems.length}
                            className={styles.deleteButton}
                        />
                        <Button onClick={toggleEditMode}>취소</Button>
                    </Space>
                ) : (
                    <Button icon={<EditIcon/>} onClick={toggleEditMode}/>
                )}
            </Space>
            <div className={styles.contentSection}>
                <List>
                    {isEditing
                        ? editingTodoList.map((todo, index) => (
                            <List.Item
                                key={index}
                                className={styles.listItem}
                            >
                                <Checkbox
                                    onChange={() => handleToggleCheckedItem(index)}
                                    checked={editingCheckedItems.includes(index)}
                                    className={styles.checkbox}
                                />
                                <Input
                                    value={todo.content}
                                    onChange={(e) => handleTodoContentChange(index, e.target.value)}
                                    rootClassName={styles.inputItem}
                                />
                            </List.Item>
                        ))
                        : todoList.map((todo, index) => (
                            <List.Item
                                key={index}
                                className={styles.listItem}
                                style={{
                                    textDecoration: todo.checked ? "line-through" : "none",
                                }}
                            >
                                <Checkbox
                                    checked={todo.checked}
                                    onChange={() => handleToggleCheckedItem(index)}
                                    className={styles.checkbox}
                                />
                                {todo.content}
                            </List.Item>
                        ))}
                </List>
            </div>
            {isEditing && (

                <Button type="default" onClick={handleAddTODO} className={styles.addButton}>
                    일정 추가하기
                </Button>

            )}
        </div>
    );
}
