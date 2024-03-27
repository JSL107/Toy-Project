<template>
  <div id="app">
    <HeaderView/>
    <router-view/>
    <FooterView/>
  </div>

</template>

<script setup lang="ts">
import HeaderView from "@/components/common/HeaderView.vue";
import FooterView from "@/components/common/FooterView.vue";
</script>

<style>
body {
  margin: 0 0 0 0;
}

header .el-drawer__header {
  margin: 0;
  padding: 0;
}

@font-face {
  font-family: 'laundry_bold';
  src: url("./assets/fonts/LaundryGothic_TTF/런드리고딕 Bold.ttf");
}

@font-face {
  font-family: 'laundry_regular';
  src: url("./assets/fonts/LaundryGothic_TTF/런드리고딕 Regular.ttf");
}

#app {
  width: 100%;
  height: 100vh;

}
</style>
