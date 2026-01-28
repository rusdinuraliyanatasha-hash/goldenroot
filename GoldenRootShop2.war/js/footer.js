(function () {
  const modal = document.getElementById("policyModal");
  const policyText = document.getElementById("policyText");
  const closeBtn = document.getElementById("closeModal");

  if (!modal || !policyText || !closeBtn) return;

  // Policy content (kau boleh edit ayat sini bila-bila)
  const policies = {
    refund: `
      <h3 id="policyTitle">Return & Refund Policy</h3>
      <p>Items can be returned within 7 days if unopened and in original packaging.</p>
      <p>Refund will be processed after inspection.</p>
    `,
    shipping: `
      <h3 id="policyTitle">Shipping Policy</h3>
      <p>Orders are processed within 1–3 working days.</p>
      <p>Delivery time depends on courier and location.</p>
    `,
    privacy: `
      <h3 id="policyTitle">Privacy Policy</h3>
      <p>Your personal data is kept confidential and used only for order processing.</p>
    `
  };

  function openModal(type) {
    policyText.innerHTML = policies[type] || "<h3 id='policyTitle'>Policy</h3><p>Content not found.</p>";
    modal.classList.add("show");
    modal.setAttribute("aria-hidden", "false");
  }

  function closeModal() {
    modal.classList.remove("show");
    modal.setAttribute("aria-hidden", "true");
  }

  // Click policy buttons
  document.querySelectorAll("[data-policy]").forEach(btn => {
    btn.addEventListener("click", () => openModal(btn.getAttribute("data-policy")));
  });

  // Close actions
  closeBtn.addEventListener("click", closeModal);
  modal.addEventListener("click", (e) => {
    if (e.target === modal) closeModal(); // click luar box tutup
  });

  // ESC key close
  document.addEventListener("keydown", (e) => {
    if (e.key === "Escape") closeModal();
  });
})();