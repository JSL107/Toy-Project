<script setup lang="ts">
import {ref} from 'vue';
import {Expand} from '@element-plus/icons-vue'
import {useRouter} from "vue-router";

const drawer = ref(false);
let router = useRouter();
const movePage = (e: HTMLElement) => {
  console.log(e.target.className);
  if (e.target.className === 'lunch-roulette') {
    router.push("/lunch");
    drawer.value = false;
  } else if (e.target.className === 'vacation') {
    router.push("/vacation");
    drawer.value = false;
  }
}

</script>

<template>
  <header class="header">
    <el-icon :size="'300%'" class='hamburger-button'>
      <Expand @click="drawer = true"/>
    </el-icon>
    <div class="drawer">
      <el-drawer direction="ltr" v-model="drawer" :size="'20%'" :show-close="false">
        <template #header>
          <img src="../../assets/logo/logo-removebg-preview.png" alt="" class="drawer-logo" @click="drawer =false"/>
        </template>
        <template #default>
          <p class="lunch-roulette" @click="(e) => movePage(e)">점심 뭐먹지</p>
          <p class="vacation" @click="(e) => movePage(e)">내 남은 휴가는</p>
        </template>
      </el-drawer>
    </div>
    <div class=" logo-area">
      <h1 @click="router.push('/')">회사생활 도우미</h1>
    </div>
  </header>
</template>

<style scoped>
.drawer-header {
  display: inline-block;
  background-color: #F6995C;
  color: #fff;
  padding: 25px;
  font-family: laundry_bold, serif;
  font-size: 25px;
  margin-bottom: 0;
}

.drawer-logo {
  width: auto;
  height: 300px;
}

.lunch-roulette {
  color: black;
  cursor: pointer;
  font-family: laundry_regular, serif;
  margin-top: 0;
  margin-bottom: 30px;
  font-size: 20px;

}

.lunch-roulette:hover {
  text-decoration: underline;
}

.vacation {
  color: black;
  cursor: pointer;
  font-family: laundry_regular, serif;
  margin-top: 0;
  margin-bottom: 30px;
  font-size: 20px;
}

.vacation:hover {
  text-decoration: underline;
}


.header {
  width: 100%;
  height: 80px;
  display: flex;
  align-items: center;
  color: black;


  .hamburger-button {
    cursor: pointer;
    margin-left: 30px;
  }
}


.logo-area {
  user-select: none;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin: 0 0 0 20px;
}

h1 {
  font-family: laundry_regular, sans-serif;
  margin-top: 0;
  margin-bottom: 0;
}

</style>
