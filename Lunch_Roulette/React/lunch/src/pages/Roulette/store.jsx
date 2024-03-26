import { configureStore, createSlice } from "@reduxjs/toolkit";
import uuid from "react-uuid";

const items = createSlice({
    name: "itemReducer",
    initialState: [
        ["todoText", "value", "id"],
        ["테스트 1", 1, uuid()],
        ["테스트 2", 1, uuid()],
    ],
    reducers: {
        LOAD_ITEMS: (state) => {
            return state;
        }
    },
});

const store = configureStore({ reducer: items.reducer });

export const {LOAD_ITEMS } = items.actions;
export default store;