<script setup lang="ts">
</script>

<template>
  <header class="header">
    <div class="logo-area">
      <img src="../../assets/logo/logo-removebg-preview.png" alt="" class="logo"/>
      <h1>땅콩</h1>
    </div>
  </header>
</template>

<style scoped>

.header {
  background-color: #9BB0C1;
  width: 100%;
  height: 8vh;
  display: flex;
  align-items: center;
  border-bottom: 1px solid grey;


  .logo-area {
    user-select: none;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin: 0 0 0 22px;

    .logo {
      margin-top: 10px;
      width: 100px;
      height: 100px;
    }
  }

  h1 {
    font-family: laundry_regular, sans-serif;
    margin-top: 0;
    margin-bottom: 0;
  }

}
</style>
