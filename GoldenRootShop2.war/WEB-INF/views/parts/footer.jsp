<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer class="footer">
  <div class="footer-container">

    <!-- LEFT: ABOUT -->
    <div class="footer-col">
      <h4>About GoldenRoot</h4>
      <p>GoldenRoot offers premium herbal products for health and wellness.</p>

      <p>
        WhatsApp:
        <a href="https://wa.me/60123456789" target="_blank" rel="noopener">Chat with us</a>
      </p>

      <p>
        Email:
        <a href="mailto:info@goldenroot.com">info@goldenroot.com</a>
      </p>
    </div>

    <!-- MIDDLE: POLICIES -->
    <div class="footer-col">
      <h4>Policies</h4>
      <ul class="policy-list">
        <li><button type="button" class="link-btn" data-policy="refund">Return & Refund Policy</button></li>
        <li><button type="button" class="link-btn" data-policy="shipping">Shipping Policy</button></li>
        <li><button type="button" class="link-btn" data-policy="privacy">Privacy Policy</button></li>
      </ul>
    </div>

    <!-- RIGHT: CONTACT -->
    <div class="footer-col">
      <h4>Contact Us</h4>
      <div class="social-icons">
  		<a href="https://www.instagram.com/golden.goldenroot?igsh=bGlxcnhmbGxnc2hp" target="_blank" aria-label="Instagram">
    	<i class="fa-brands fa-instagram"></i>
  		</a>

  		<a href="https://www.tiktok.com/@goldenroot79?_r=1&_t=ZS-93G6QXsXf76" target="_blank" aria-label="TikTok">
    	<i class="fa-brands fa-tiktok"></i>
  		</a>

  		<a href="https://www.facebook.com/goldenrootttt/" target="_blank" aria-label="Facebook">
    	<i class="fa-brands fa-facebook-f"></i>
  		</a>
</div>

    </div>

  </div>

  <div class="footer-bottom">
    © 2026 GoldenRoot. All Rights Reserved.
  </div>
</footer>

<!-- MODAL POPUP (Policy) -->
<div id="policyModal" class="modal" aria-hidden="true">
  <div class="modal-content" role="dialog" aria-modal="true" aria-labelledby="policyTitle">
    <button type="button" class="close" id="closeModal" aria-label="Close">&times;</button>
    <div id="policyText"></div>
  </div>
</div>

<script src="<%=request.getContextPath()%>/js/footer.js"></script>

