<script>
export default {
  data() {
    return {
      items: [],
    };
  },
  methods: {
    async fetchData() {
      try {
        const response = await fetch("http://localhost:3333/api/content");
        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        this.items = await response.json();
        // console.log("Data fetched successfully:", this.items);
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },
  },
  mounted() {
    this.fetchData();
  },
};
</script>

<template>
  <div>
    <h1>Home</h1>
    <ul v-if="items.length">
      <li v-for="item in items" :key="item.id">{{ item.content }}</li>
    </ul>
    <p v-else>No items found.</p>
  </div>
</template>

<style scoped></style>
