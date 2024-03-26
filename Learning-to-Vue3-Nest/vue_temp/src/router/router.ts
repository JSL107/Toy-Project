import {createWebHistory, createRouter} from "vue-router";
import VacationCounter from "@/components/vacation/VacationCounter.vue";
import MainView from "@/components/main/MainView.vue";

const routes = [
    {
        path: "/",
        name: "MainPage",
        component: MainView,
    },
    {
        path: "/counter",
        name: "VacationCounter",
        component: VacationCounter,
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router; // 수정된 부분
