<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Admin Login</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

  <style>
    /* ✅ UI ONLY: jangan ubah flow/method/action */
    .login-wrap{
      min-height: calc(100vh - 40px);
      display:flex;
      align-items:center;
      justify-content:center;
      padding: 24px 0;
    }

    .login-shell{
      width:100%;
      max-width: 980px;
      display:grid;
      grid-template-columns: 1.1fr 0.9fr;
      gap: 18px;
      align-items:stretch;
    }

    /* Left promo panel */
    .login-hero{
      border-radius: 18px;
      padding: 28px;
      position: relative;
      overflow:hidden;
      background: linear-gradient(135deg, rgba(245,124,0,.18), rgba(255,255,255,1));
      border: 1px solid rgba(245,124,0,.18);
      box-shadow: 0 10px 30px rgba(0,0,0,.06);
    }

    .brand-top{
      display:flex;
      align-items:center;
      gap:10px;
      margin-bottom: 14px;
    }

    /* ✅ Kalau ada logo, guna <img class="brand-logo" ...> */
    .brand-logo{
      width:42px;
      height:42px;
      border-radius: 12px;
      object-fit:cover;
      border: 1px solid rgba(0,0,0,.08);
      background:#fff;
    }

    .brand-title{
      margin:0;
      font-size: 22px;
      font-weight: 900;
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
      max-width: 52ch;
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
      font-weight: 800;
      font-size: 12px;
      color: rgba(0,0,0,.75);
    }

    .pill-dot{
      width:8px;
      height:8px;
      border-radius: 999px;
      background:#f57c00;
      box-shadow: 0 0 0 3px rgba(245,124,0,.12);
    }

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
    .login-card{
      border-radius: 18px;
      padding: 22px 22px 18px;
      border: 1px solid rgba(0,0,0,.08);
      box-shadow: 0 10px 30px rgba(0,0,0,.06);
      background:#fff;
      display:flex;
      flex-direction:column;
      justify-content:center;
    }

    .login-title{
      margin:0 0 6px 0;
      font-size: 22px;
      font-weight: 950;
      color:#111;
    }

    .login-subtitle{
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
      font-weight: 800;
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

    .field input{
      width:100%;
      padding: 12px 12px;
      border-radius: 12px;
      border: 1px solid rgba(0,0,0,.14);
      outline: none;
      background:#fff;
      font-size: 14px;
      transition: box-shadow .15s ease, border-color .15s ease;
    }

    .field input:focus{
      border-color: rgba(245,124,0,.65);
      box-shadow: 0 0 0 4px rgba(245,124,0,.12);
    }

    .btn-row{
      display:flex;
      gap:10px;
      align-items:center;
      margin-top: 4px;
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
      display:flex;
      flex-direction:column;
      gap:8px;
      font-size: 0.95rem;
      opacity: 0.9;
      margin-top: 6px;
    }

    .muted-links a{
      color:#f57c00;
      font-weight: 800;
      text-decoration:none;
    }

    .muted-links a:hover{
      text-decoration: underline;
    }

    /* Responsive */
    @media (max-width: 860px){
      .login-shell{ grid-template-columns: 1fr; }
      .login-hero{ display:none; }
      .login-card{ max-width: 520px; margin: 0 auto; }
    }
  </style>
</head>

<body>

<div class="login-wrap">
  <div class="login-shell">

    <!-- LEFT: branding / marketing (UI sahaja) -->
    <div class="login-hero">
      <div class="brand-top">
        <!-- Kalau ada logo, letak sini -->
        <!-- <img class="brand-logo" src="<%=request.getContextPath()%>/images/logo.png" alt="Golden Root"> -->
        <div>
          <p class="brand-title">Golden Root</p>
          <p class="brand-sub">Admin Panel Access</p>
        </div>
      </div>

      <h1 class="hero-headline">Admin Login</h1>
      <p class="hero-desc">
        Please enter your admin credentials to continue.
      </p>

      <div class="hero-pills">
        <span class="pill"><span class="pill-dot"></span> Secure access</span>
        <span class="pill"><span class="pill-dot"></span> Manage orders</span>
        <span class="pill"><span class="pill-dot"></span> Refund handling</span>
      </div>

      <div class="hero-art"></div>
    </div>

    <!-- RIGHT: form card (FLOW KEKAL) -->
    <div class="login-card">
      <h2 class="login-title">Admin Login</h2>
      <p class="login-subtitle">Please enter your admin credentials to continue.</p>

      <% String err = (String) request.getAttribute("error"); %>
      <% if (err != null) { %>
        <p class="error"><%= err %></p>
      <% } %>

      <!-- ✅ jangan ubah method/action -->
      <form method="post" action="<%=request.getContextPath()%>/admin/login">

        <!-- ✅ PENTING: ikut servlet => username -->
        <div class="field">
          <label>Username</label>
          <input type="text" name="username" placeholder="admin username" required>
        </div>

        <div class="field">
          <label>Password</label>
          <input type="password" name="password" placeholder="Password" required>
        </div>

        <div class="btn-row">
          <button class="btn btn-primary" type="submit">Login</button>
        </div>
      </form>

      <div class="divider"></div>

      <div class="muted-links">
        <div>
          Back to user login?
          <a href="<%=request.getContextPath()%>/login">Go to User Login</a>
        </div>
      </div>

    </div>

  </div>
</div>

</body>
</html>
