<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Register</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

  <style>
    /* ✅ UI ONLY — jangan ubah method/action/name input */

    .auth-wrap{
      min-height: calc(100vh - 40px);
      display:flex;
      align-items:center;
      justify-content:center;
      padding: 24px 0;
    }

    .auth-shell{
      width:100%;
      max-width: 980px;
      display:grid;
      grid-template-columns: 1.1fr 0.9fr;
      gap: 18px;
      align-items:stretch;
    }

    /* Left promo panel */
    .auth-hero{
      border-radius: 18px;
      padding: 28px;
      position: relative;
      overflow:hidden;
      border: 1px solid rgba(245,124,0,.18);
      box-shadow: 0 10px 30px rgba(0,0,0,.06);
      background:
        linear-gradient(135deg, rgba(245,124,0,.18), rgba(255,255,255,1));
    }

    .brand-top{
      display:flex;
      align-items:center;
      gap:10px;
      margin-bottom: 14px;
    }

    .brand-badge{
      width:44px;
      height:44px;
      border-radius: 14px;
      display:grid;
      place-items:center;
      background: rgba(245,124,0,.12);
      border: 1px solid rgba(245,124,0,.18);
      font-weight: 950;
      color:#f57c00;
      letter-spacing:.5px;
    }

    .brand-title{
      margin:0;
      font-size: 22px;
      font-weight: 950;
      color:#111;
      line-height: 1.1;
    }

    .brand-sub{
      margin:0;
      margin-top: 2px;
      color: rgba(0,0,0,.6);
      font-weight: 600;
      font-size: 13px;
    }

    .hero-headline{
      margin: 18px 0 8px 0;
      font-size: 34px;
      line-height: 1.1;
      font-weight: 950;
      color:#111;
    }

    .hero-desc{
      margin:0;
      color: rgba(0,0,0,.65);
      font-size: 14px;
      line-height: 1.6;
      max-width: 54ch;
    }

    .hero-pills{
      display:flex;
      gap:10px;
      flex-wrap:wrap;
      margin-top: 16px;
    }

    .pill{
      display:inline-flex;
      align-items:center;
      gap:8px;
      padding: 8px 10px;
      border-radius: 999px;
      background: rgba(255,255,255,.75);
      border: 1px solid rgba(0,0,0,.06);
      font-weight: 850;
      font-size: 12px;
      color: rgba(0,0,0,.75);
    }

    .pill i{ color:#f57c00; }

    .hero-art{
      position:absolute;
      right:-70px;
      bottom:-70px;
      width: 260px;
      height: 260px;
      border-radius: 60px;
      background: radial-gradient(circle at 30% 30%, rgba(245,124,0,.25), rgba(245,124,0,.0) 60%),
                  radial-gradient(circle at 70% 70%, rgba(0,0,0,.06), rgba(0,0,0,0) 55%);
      transform: rotate(18deg);
      pointer-events:none;
    }

    /* Right card (form) */
    .auth-card{
      border-radius: 18px;
      padding: 22px 22px 18px;
      border: 1px solid rgba(0,0,0,.08);
      box-shadow: 0 10px 30px rgba(0,0,0,.06);
      background:#fff;
      display:flex;
      flex-direction:column;
      justify-content:center;
    }

    .auth-title{
      margin:0 0 6px 0;
      font-size: 22px;
      font-weight: 950;
      color:#111;
    }

    .auth-subtitle{
      margin:0 0 16px 0;
      color: rgba(0,0,0,.6);
      font-size: 13px;
      line-height: 1.5;
    }

    .error{
      background: rgba(198,40,40,.08);
      border: 1px solid rgba(198,40,40,.18);
      color:#c62828;
      padding: 10px 12px;
      border-radius: 12px;
      font-weight: 850;
      margin: 0 0 12px 0;
    }

    .field{
      display:flex;
      flex-direction:column;
      gap:6px;
      margin-bottom: 12px;
    }

    .field label{
      font-weight: 900;
      font-size: 13px;
      color: rgba(0,0,0,.75);
    }

    .input-wrap{
      position: relative;
    }

    .input-ico{
      position:absolute;
      left: 12px;
      top: 50%;
      transform: translateY(-50%);
      color: rgba(0,0,0,.35);
      font-size: 14px;
      pointer-events:none;
    }

    .field input{
      width:100%;
      padding: 12px 12px 12px 38px; /* space untuk icon */
      border-radius: 12px;
      border: 1px solid rgba(0,0,0,.14);
      outline: none;
      background:#fff;
      font-size: 14px;
      transition: box-shadow .15s ease, border-color .15s ease, transform .05s ease;
    }

    .field input:focus{
      border-color: rgba(245,124,0,.65);
      box-shadow: 0 0 0 4px rgba(245,124,0,.12);
    }

    .hint{
      font-size: 12px;
      color: rgba(0,0,0,.55);
      margin-top: 2px;
      line-height: 1.4;
    }

    .btn-row{
      display:flex;
      gap:10px;
      align-items:center;
      margin-top: 6px;
    }

    .btn.btn-primary{
      flex:1;
      border-radius: 12px;
      padding: 12px 14px;
      font-weight: 950;
      letter-spacing: .2px;
    }

    .divider{
      margin: 14px 0 12px;
      height:1px;
      background: rgba(0,0,0,.06);
    }

    .muted-links{
      font-size: 0.95rem;
      opacity: 0.9;
    }

    .muted-links a{
      color:#f57c00;
      font-weight: 850;
      text-decoration:none;
    }

    .muted-links a:hover{
      text-decoration: underline;
    }

    /* Responsive */
    @media (max-width: 860px){
      .auth-shell{ grid-template-columns: 1fr; }
      .auth-hero{ display:none; }
      .auth-card{ max-width: 560px; margin: 0 auto; }
    }
  </style>
</head>

<body>

<div class="auth-wrap">
  <div class="auth-shell">

    <!-- LEFT: branding / marketing (UI sahaja) -->
    <div class="auth-hero">
      <div class="brand-top">
        
        <div>
          <p class="brand-title">Golden Root</p>
          <p class="brand-sub">The Essence of Golden Purity</p>
        </div>
      </div>

      <h1 class="hero-headline">Create your account</h1>
      <p class="hero-desc">
        
      </p>

      <div class="hero-pills">
        <span class="pill"><i class="fa-solid fa-shield-halved"></i> Secure account</span>
        <span class="pill"><i class="fa-solid fa-truck-fast"></i> Track deliveries</span>
        <span class="pill"><i class="fa-solid fa-bag-shopping"></i> Faster checkout</span>
      </div>

      <div class="hero-art"></div>
    </div>

    <!-- RIGHT: form card (FLOW KEKAL) -->
    <div class="auth-card">
      <h2 class="auth-title">Create Account</h2>
      <p class="auth-subtitle">Fill in your details to register.</p>

      <% String err = (String) request.getAttribute("error"); %>
      <% if (err != null) { %>
        <p class="error"><%= err %></p>
      <% } %>

      <!-- ✅ jangan ubah method/action/name input -->
      <form method="post" action="<%=request.getContextPath()%>/register">

        <div class="field">
          <label>Full Name</label>
          <div class="input-wrap">
            <span class="input-ico"><i class="fa-solid fa-user"></i></span>
            <input type="text" name="full_name" placeholder="Your full name" required>
          </div>
        </div>

        <div class="field">
          <label>Email</label>
          <div class="input-wrap">
            <span class="input-ico"><i class="fa-solid fa-envelope"></i></span>
            <input type="email" name="email" placeholder="example@gmail.com" required>
          </div>
        </div>

        <div class="field">
          <label>Password</label>
          <div class="input-wrap">
            <span class="input-ico"><i class="fa-solid fa-lock"></i></span>
            <input type="password" name="password" placeholder="Password" required>
          </div>
          <div class="hint">Tip: Use at least 8 characters for better security.</div>
        </div>

        <div class="field">
          <label>Confirm Password</label>
          <div class="input-wrap">
            <span class="input-ico"><i class="fa-solid fa-lock"></i></span>
            <input type="password" name="confirmPassword" placeholder="Confirm password" required>
          </div>
        </div>

        <div class="btn-row">
          <button class="btn btn-primary" type="submit">Register</button>
        </div>
      </form>

      <div class="divider"></div>

      <div class="muted-links">
        Already have an account?
        <a href="<%=request.getContextPath()%>/login">Login</a>
      </div>
    </div>

  </div>
</div>

</body>
</html>
