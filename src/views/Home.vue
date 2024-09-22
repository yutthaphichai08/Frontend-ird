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
          <th>Handle</th>
        </tr>
      </thead>
      <tbody>
        <tr v-if="paginatedItems.length === 0">
          <td colspan="3">No items found.</td>
        </tr>
        <tr v-for="item in paginatedItems" :key="item.id">
          <td>{{ item.id }}</td>
          <td>{{ item.content }}</td>
          <td>
            <button @click="editItem(item)" class="btn btn-link text-primary">
              <i class="fas fa-edit"></i>
            </button>
            <button
              @click="deleteItem(item.id)"
              class="btn btn-link text-danger"
            >
              <i class="fas fa-trash-alt"></i>
            </button>
          </td>
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
          confirmButtonText: "OK",
        });

        this.fetchData();
      } catch (error) {
        console.log("Error adding content:", error);
      }
    },
    async deleteItem(id) {
      const confirmDelete = await Swal.fire({
        title: "คุณแน่ใจ?",
        text: "คุณจะไม่สามารถเปลี่ยนกลับสิ่งนี้ได้!",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Yes, delete it!",
      });

      if (confirmDelete.isConfirmed) {
        try {
          const response = await fetch(
            `http://localhost:3333/api/delete/${id}`,
            {
              method: "DELETE",
              headers: {
                "Content-Type": "application/json",
              },
            }
          );

          if (!response.ok) {
            throw new Error("Network response was not ok");
          }

          Swal.fire("Deleted!", "Your file has been deleted.", "success");
          this.fetchData();
        } catch (error) {
          console.error("Error deleting content:", error);
        }
      }
    },
    editItem(item) {},
  },
  mounted() {
    this.fetchData();
  },
};
</script>

<style scoped>
/* Add any scoped styles here */
.pagination {
  cursor: pointer;
}
</style>
