import {createWebHistory, createRouter} from "vue-router";
import VacationCounterView from "@/components/vacation/VacationCounterView.vue";
import LunchRouletteView from "@/components/roulette/LunchRouletteView.vue";
import MainView from "@/components/main/MainView.vue";

const routes = [
    {
        path: "/",
        name: "MainPage",
        component: MainView,
    },
    {
        path: "/vacation",
        name: "VacationCounterView",
        component: VacationCounterView,
    },
    {
        path: "/lunch",
        name: "LunchRouletteView",
        component: LunchRouletteView,
    },
];

const router = createRouter({
    history: createWebHistory(),
    routes,
});

export default router; // 수정된 부분
