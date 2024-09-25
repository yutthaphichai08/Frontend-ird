<template>
  <nav class="navbar bg-dark border-bottom border-body" data-bs-theme="dark">
    <div class="container-fluid">
      <!-- <a class="navbar-brand" href="/users" style="color: white">Login</a> -->

      <div class="container-button">
        <ExportButton />
        <ImportButton />
      </div>
      <button type="button" class="btn btn-danger" @click="clearLocalStorage">
        <i class="bi bi-power">Logout</i>
      </button>
    </div>
  </nav>
</template>

<script>
import ExportButton from "./ExportButton.vue";
import ImportButton from "./ImportButton.vue";

export default {
  components: {
    ExportButton,
    ImportButton,
  },
  methods: {
    openModal() {
      const modalElement = this.$refs.modal.$el;
      const modal = new bootstrap.Modal(modalElement);
      modal.show();
    },
    clearLocalStorage() {
      const userConfirmed = window.confirm("คุณต้องการออกจากระบบใช่หรือไม่?");
      if (userConfirmed) {
        try {
          localStorage.clear();
          window.location.href = "/";
        } catch (error) {
          console.error("Failed to logout", error);
        }
      }
    },
  },
};
</script>
<style scoped>
.container-button {
  display: flex;
  gap: 6px;
}
</style>
