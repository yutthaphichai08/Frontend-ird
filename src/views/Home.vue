<script>
import Swal from "sweetalert2";

export default {
  data() {
    return {
      items: [],
      newContent: { content: "" },
      currentPage: 1,
      itemsPerPage: 10,
    };
  },
  computed: {
    paginatedItems() {
      const start = (this.currentPage - 1) * this.itemsPerPage;
      return this.items.slice(start, start + this.itemsPerPage);
    },
    totalPages() {
      return Math.ceil(this.items.length / this.itemsPerPage);
    },
  },
  methods: {
    async fetchData() {
      try {
        const response = await fetch("http://localhost:3333/api/content", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
        });

        if (!response.ok) {
          throw new Error("Network response was not ok");
        }
        this.items = await response.json();
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    },
    async addItem() {
      try {
        const response = await fetch("http://localhost:3333/api/insert", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify(this.newContent),
        });

        if (!response.ok) {
          throw new Error("Network response was not ok");
        }

        const data = await response.json();
        this.newContent = data;

        Swal.fire({
          title: "สำเร็จ!",
          text: "เพิ่มข้อมูลเรียบร้อยแล้ว",
          icon: "success",
          confirmButtonText: "ตกลง",
        });

        this.fetchData();
      } catch (error) {
        console.log("Error adding content:", error);
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
    <!-- Form to add new item -->
    <form @submit.prevent="addItem">
      <div class="mb-3">
        <label for="content" class="form-label">Content</label>
        <input
          type="text"
          id="content"
          v-model="newContent.content"
          class="form-control"
          required
        />
      </div>
      <button type="submit" class="btn btn-primary">Add Content</button>
    </form>

    <table class="table mt-3">
      <thead>
        <tr>
          <th>ID</th>
          <th>Content</th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="paginatedItems.length === 0">
          <td colspan="2">No items found.</td>
        </tr>
        <tr v-for="item in paginatedItems" :key="item.id">
          <td>{{ item.id }}</td>
          <td>{{ item.content }}</td>
        </tr>
      </tbody>
    </table>

    <nav>
      <ul class="pagination">
        <li class="page-item" :class="{ disabled: currentPage === 1 }">
          <a class="page-link" @click="currentPage--">Previous</a>
        </li>
        <li
          v-for="page in totalPages"
          :key="page"
          class="page-item"
          :class="{ active: currentPage === page }"
        >
          <a class="page-link" @click="currentPage = page">{{ page }}</a>
        </li>
        <li class="page-item" :class="{ disabled: currentPage === totalPages }">
          <a class="page-link" @click="currentPage++">Next</a>
        </li>
      </ul>
    </nav>
  </div>
</template>

<style scoped></style>
