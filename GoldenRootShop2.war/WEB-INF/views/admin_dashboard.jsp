<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html>
<head>
  <title>Admin Dashboard</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

  <style>
    :root{
      --orange:#f57c00;
      --orange-dark:#ef6c00;
      --orange-soft:#fff3e0;
      --bg:#fff;
      --text:#121212;
      --muted:rgba(0,0,0,.6);
      --border:rgba(0,0,0,.08);
      --shadow:0 12px 32px rgba(0,0,0,.08);
      --chip:rgba(245,124,0,.12);
    }

    body{ background:#fafafa; }

    /* ================= HEADER ================= */
    .page-head{ padding:22px 0 10px; }
    .head-row{ display:flex; justify-content:space-between; gap:14px; flex-wrap:wrap; }

    .title{
      margin:0;
      font-size:26px;
      font-weight:950;
      color:var(--text);
    }
    .subtitle{
      margin-top:6px;
      color:var(--muted);
      font-weight:600;
    }

    /* 🔥 FIXED ADMIN NAV BUTTONS */
    .admin-nav{
      display:flex;
      gap:14px;
      margin-top:16px;
      flex-wrap:wrap;
    }
    .admin-nav a{
      padding:14px 26px;
      border-radius:999px;
      font-weight:950;
      text-decoration:none;
      color:#fff;
      background:linear-gradient(135deg,#ff9800,#f57c00);
      box-shadow:0 10px 24px rgba(245,124,0,.35);
      transition:all .25s ease;
    }
    .admin-nav a:hover{
      transform:translateY(-3px);
      background:linear-gradient(135deg,#ffa726,#ef6c00);
      box-shadow:0 18px 36px rgba(245,124,0,.45);
    }
    .admin-nav a:active{
      transform:translateY(0);
      box-shadow:0 8px 16px rgba(245,124,0,.35);
    }

    /* ================= KPI ================= */
    .kpi-grid{
      display:grid;
      grid-template-columns:1.2fr 1fr 1fr;
      gap:12px;
    }
    .kpi-card{
      background:#fff;
      border-radius:16px;
      border:1px solid var(--border);
      box-shadow:var(--shadow);
      padding:16px;
      position:relative;
      overflow:hidden;
    }
    .kpi-label{ color:var(--muted); font-weight:800; font-size:13px; }
    .kpi-value{ font-size:34px; font-weight:950; margin-top:8px; }
    .kpi-hint{ margin-top:8px; font-size:12px; font-weight:600; color:var(--muted); }

    /* ================= FILTER ================= */
    .filter-bar{
      display:flex;
      justify-content:space-between;
      gap:10px;
      flex-wrap:wrap;
      padding:14px;
      border-radius:16px;
      border:1px solid var(--border);
      background:rgba(255,255,255,.85);
      backdrop-filter:blur(8px);
      box-shadow:var(--shadow);
    }
    .filter-left{ display:flex; gap:10px; flex-wrap:wrap; }
    .fgroup{ display:flex; flex-direction:column; gap:6px; min-width:180px; }
    .fgroup label{ font-size:12px; font-weight:900; }
    .fgroup input,.fgroup select{
      padding:10px 12px;
      border-radius:12px;
      border:1px solid rgba(0,0,0,.14);
    }
    .btn-soft{
      padding:10px 12px;
      border-radius:12px;
      background:#fff;
      border:1px solid rgba(0,0,0,.12);
      font-weight:950;
      cursor:pointer;
    }

    /* ================= GRAPH ================= */
    .cardx{
      background:#fff;
      border-radius:16px;
      border:1px solid var(--border);
      box-shadow:var(--shadow);
      padding:16px;
    }
    .cardx-title{ margin:0; font-size:18px; font-weight:950; }
    .cardx-sub{ margin-top:6px; font-size:12px; color:var(--muted); }

    .bar-list{ margin-top:10px; display:flex; flex-direction:column; gap:10px; }
    .bar-row{
      display:grid;
      grid-template-columns:1.2fr 1.6fr 90px;
      gap:12px;
      align-items:center;
      padding:10px;
      border-radius:14px;
      border:1px solid rgba(0,0,0,.06);
      background:#fff;
    }
    .bar-name{ font-weight:950; }
    .bar-meta{ font-size:12px; color:var(--muted); }
    .bar-track{
      height:14px;
      background:rgba(0,0,0,.06);
      border-radius:999px;
      overflow:hidden;
    }
    .bar-fill{
      height:100%;
      background:var(--orange);
      border-radius:999px;
      width:0%;
      transition:width .35s ease;
    }
    .bar-qty{ text-align:right; font-weight:950; }

    @media(max-width:980px){
      .kpi-grid{ grid-template-columns:1fr; }
    }
  </style>
</head>

<body>

<div class="container page-head">
  <div class="head-row">
    <div>
      <h2 class="title">Admin Dashboard</h2>
      <p class="subtitle">Quick overview to monitor sales and product demand.</p>

      <!-- BUTTON KEKAL + CANTIK -->
      <div class="admin-nav">
        <a href="<%=request.getContextPath()%>/admin/orders">View Orders</a>
        <a href="<%=request.getContextPath()%>/admin/products">Manage Products</a>
        <a href="<%=request.getContextPath()%>/admin/logout">Logout</a>
      </div>
    </div>
  </div>
</div>

<div class="container">

<%
  Object totalOrdersObj = request.getAttribute("totalOrders");
  int totalOrders = 0;
  try { totalOrders = Integer.parseInt(String.valueOf(totalOrdersObj)); } catch(Exception ignore){}

  List<String[]> top = (List<String[]>) request.getAttribute("topProducts");
  int productCount = (top == null ? 0 : top.size());

  int totalSoldTop = 0;
  if (top != null) {
    for (String[] row : top) {
      try { totalSoldTop += Integer.parseInt(row[2]); } catch(Exception ignore){}
    }
  }
%>

<!-- KPI -->
<div class="kpi-grid">
  <div class="kpi-card">
    <div class="kpi-label">Total Orders</div>
    <div class="kpi-value"><%= totalOrders %></div>
    <div class="kpi-hint">Total orders in the system.</div>
  </div>

  <div class="kpi-card">
    <div class="kpi-label">Top Products</div>
    <div class="kpi-value"><%= productCount %></div>
    <div class="kpi-hint">Products with highest demand.</div>
  </div>

  <div class="kpi-card">
    <div class="kpi-label">Units Sold (Top)</div>
    <div class="kpi-value"><%= totalSoldTop %></div>
    <div class="kpi-hint">Total units sold (top products).</div>
  </div>
</div>

<div style="height:14px;"></div>

<!-- FILTER BAR -->
<div class="filter-bar">
  <div class="filter-left">
    <div class="fgroup">
      <label>From Date</label>
      <input type="date" id="fromDate">
    </div>
    <div class="fgroup">
      <label>To Date</label>
      <input type="date" id="toDate">
    </div>
    <div class="fgroup">
      <label>Status</label>
      <select id="statusFilter">
        <option value="ALL">All</option>
        <option value="COMPLETED">Completed</option>
        <option value="CANCELLED">Cancelled</option>
      </select>
    </div>
    <div class="fgroup">
      <label>Search Product</label>
      <input type="text" id="searchProduct">
    </div>
  </div>

  <button class="btn-soft" id="btnClear">Clear</button>
</div>

<div style="height:14px;"></div>

<!-- GRAPH -->
<div class="cardx">
  <h3 class="cardx-title">Top High Demand Products</h3>
  <p class="cardx-sub">Units sold for the most demanded products.</p>

<%
  int maxQty = 1;
  if (top != null) {
    for (String[] r : top) {
      try { maxQty = Math.max(maxQty, Integer.parseInt(r[2])); } catch(Exception ignore){}
    }
  }
%>

<div class="bar-list">
<% if (top != null) {
   for (String[] r : top) {
     int qty = Integer.parseInt(r[2]);
     int pct = (int)((qty * 100.0) / maxQty);
%>
  <div class="bar-row bar-item" data-name="<%= r[1].toLowerCase() %>">
    <div>
      <div class="bar-name"><%= r[1] %></div>
      <div class="bar-meta">Product ID: <%= r[0] %></div>
    </div>
    <div class="bar-track">
      <div class="bar-fill" style="width:<%= pct %>%"></div>
    </div>
    <div class="bar-qty"><%= qty %></div>
  </div>
<% }} %>
</div>

</div>
</div>

<script>
  const searchProduct = document.getElementById('searchProduct');
  searchProduct.addEventListener('input', () => {
    const q = searchProduct.value.toLowerCase();
    document.querySelectorAll('.bar-item').forEach(el => {
      el.style.display = el.dataset.name.includes(q) ? '' : 'none';
    });
  });

  window.addEventListener('load', () => {
    document.querySelectorAll('.bar-fill').forEach(b => {
      const w = b.style.width;
      b.style.width = '0%';
      setTimeout(()=>b.style.width=w,120);
    });
  });
</script>

</body>
</html>
