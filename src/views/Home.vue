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
  <div class="container">
    <h1>Home</h1>
    <table class="table">
      <thead>
        <tr>
          <th>ID</th>
          <th>Content</th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="items.length === 0">
          <td colspan="2">No items found.</td>
        </tr>
        <tr v-for="item in items" :key="item.id">
          <td>{{ item.id }}</td>
          <td>{{ item.content }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<style scoped></style>
