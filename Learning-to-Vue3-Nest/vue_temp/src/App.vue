<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script setup lang="ts">
</script>

<style>
body {
  margin: 0 0 0 0;
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
  height: 100%;

}
</style>
