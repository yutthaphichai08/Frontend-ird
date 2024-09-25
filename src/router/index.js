import { createRouter, createWebHistory } from "vue-router";
import Home from "../views/Home.vue";
import ListComment from "../views/ListComment.vue";

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/comment",
    name: "Comment",
    component: ListComment,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
