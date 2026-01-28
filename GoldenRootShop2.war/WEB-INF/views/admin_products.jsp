<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Product" %>
<%@ page import="model.Category" %>

<!DOCTYPE html>
<html>
<head>
  <title>Manage Products</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

  <style>
    :root{
      --orange:#f57c00;
      --orange-dark:#ef6c00;
      --orange-soft:#fff3e0;
    }

    body {
      background:#fff;
      color:#333;
      font-family:'Segoe UI', system-ui, -apple-system;
    }

    h2,h3{ font-weight:900; }

    /* =======================
       🔥 ADMIN NAV (UPGRADED)
    ======================= */
    .admin-nav{
      display:flex;
      gap:14px;
      flex-wrap:wrap;
      margin:18px 0 28px;
    }

    .admin-nav a{
      position:relative;
      padding:14px 26px;
      border-radius:999px;
      font-weight:950;
      text-decoration:none;
      color:#fff;
      background:linear-gradient(135deg,#ff9800,#f57c00);
      box-shadow:
        0 10px 24px rgba(245,124,0,.35),
        inset 0 -2px 0 rgba(0,0,0,.12);
      transition:all .25s ease;
    }

    .admin-nav a::after{
      content:"";
      position:absolute;
      inset:0;
      border-radius:inherit;
      box-shadow:0 0 0 0 rgba(245,124,0,.45);
      opacity:0;
      transition:.25s;
    }

    .admin-nav a:hover{
      transform:translateY(-3px);
      background:linear-gradient(135deg,#ffa726,#ef6c00);
      box-shadow:
        0 18px 36px rgba(245,124,0,.45),
        inset 0 -2px 0 rgba(0,0,0,.18);
    }

    .admin-nav a:hover::after{
      opacity:1;
      box-shadow:0 0 0 8px rgba(245,124,0,.18);
    }

    .admin-nav a:active{
      transform:translateY(0);
      box-shadow:
        0 8px 16px rgba(245,124,0,.35),
        inset 0 3px 6px rgba(0,0,0,.22);
    }

    /* CARD */
    .card{
      background:#fff;
      border-radius:18px;
      padding:22px;
      box-shadow:0 12px 28px rgba(0,0,0,.05);
      border:1px solid #f1f1f1;
      margin-bottom:20px;
    }

    /* TABLE */
    .table{ width:100%; border-collapse:collapse; }
    .table th{
      background:#fff8f1;
      color:var(--orange);
      font-weight:900;
      padding:14px;
      border-bottom:2px solid #ffe0b2;
      text-align:left;
    }
    .table td{
      padding:14px;
      border-bottom:1px solid #eee;
      vertical-align:top;
    }
    .table tr:hover{ background:#fffdf9; }

    .img-mini{
      width:58px;
      height:58px;
      object-fit:cover;
      border-radius:14px;
      border:1px solid #eee;
    }

    /* FORM */
    .form-grid{
      display:grid;
      grid-template-columns:repeat(2,1fr);
      gap:14px;
    }
    .form-grid .full{ grid-column:1/-1; }

    label{ font-weight:800; margin-bottom:6px; display:block; }

    input,select,textarea{
      width:100%;
      padding:12px 14px;
      border-radius:12px;
      border:1px solid #ddd;
      font-size:14px;
    }

    input:focus,select:focus,textarea:focus{
      outline:none;
      border-color:var(--orange);
      box-shadow:0 0 0 2px rgba(245,124,0,.15);
    }

    /* BUTTONS */
    .btn{
      padding:12px 22px;
      border-radius:999px;
      border:none;
      font-weight:900;
      cursor:pointer;
      background:#ffe0b2;
      color:#e65100;
      transition:.2s;
    }
    .btn:hover{
      background:var(--orange);
      color:#fff;
    }

    .btn-primary{
      background:var(--orange);
      color:#fff;
    }
    .btn-primary:hover{ background:var(--orange-dark); }

    .btn-sm{
      padding:8px 12px;
      font-size:12px;
    }

    /* STATUS */
    .pill{
      display:inline-block;
      padding:6px 12px;
      border-radius:999px;
      font-size:11px;
      font-weight:900;
    }
    .pill-on{ background:#e8f5e9; color:#2e7d32; }
    .pill-off{ background:#ffebee; color:#c62828; }

    .actions{
      display:flex;
      gap:8px;
      flex-wrap:wrap;
    }

    .muted{ opacity:.7; font-size:13px; }
  </style>
</head>

<body>

<div class="container" style="padding:26px 0;">
  <h2 style="color:var(--orange);margin:0;">Manage Products</h2>

  <!-- 🔥 NAV BUTTONS (SAME VIBE AS DASHBOARD) -->
  <div class="admin-nav">
    <a href="<%=request.getContextPath()%>/admin/dashboard">Dashboard</a>
    <a href="<%=request.getContextPath()%>/admin/orders">View Orders</a>
    <a href="<%=request.getContextPath()%>/admin/logout">Logout</a>
  </div>
</div>

<div class="container">

<%
  List<Category> cats = (List<Category>) request.getAttribute("categories");
  List<Product> products = (List<Product>) request.getAttribute("products");
%>

<!-- ADD PRODUCT -->
<div class="card">
  <h3>Add New Product</h3>

  <form method="post" action="<%=request.getContextPath()%>/admin/products">
    <input type="hidden" name="action" value="add"/>

    <div class="form-grid">
      <div>
        <label>Category</label>
        <select name="categoryId" required>
          <% if (cats != null) { for (Category c : cats) { %>
            <option value="<%=c.getId()%>"><%=c.getName()%></option>
          <% }} %>
        </select>
      </div>

      <div>
        <label>Price (RM)</label>
        <input type="number" step="0.01" name="price" required>
      </div>

      <div class="full">
        <label>Product Name</label>
        <input type="text" name="name" required>
      </div>

      <div class="full">
        <label>Description</label>
        <textarea name="description" required></textarea>
      </div>

      <div class="full">
        <label>Image URL</label>
        <input type="text" name="imageUrl" required>
        <div class="muted">Example: images/p1.jpg</div>
      </div>

      <div class="full">
        <label>Image 2 URL</label>
        <input type="text" name="image2">
      </div>

      <div class="full">
        <label>Image 3 URL</label>
        <input type="text" name="image3">
      </div>

      <div class="full">
        <label>Video URL</label>
        <input type="text" name="videoUrl">
      </div>
    </div>

    <button class="btn btn-primary" type="submit" style="margin-top:16px;">
      Add Product
    </button>
  </form>
</div>

<!-- PRODUCT LIST -->
<div class="card">
  <h3>All Products</h3>

<% if (products == null || products.isEmpty()) { %>
  <p class="muted">No products found.</p>
<% } else { %>

<table class="table">
<tr>
  <th>ID</th>
  <th>Image</th>
  <th>Details</th>
  <th>Category</th>
  <th>Price</th>
  <th>Status</th>
  <th>Actions</th>
</tr>

<% for (Product p : products) { %>
<tr>
<td><%=p.getId()%></td>

<td>
<img class="img-mini" src="<%=request.getContextPath()%>/<%=p.getImageUrl()%>">
</td>

<td>
<div style="font-weight:900;"><%=p.getName()%></div>
<div class="muted"><%=p.getDescription()%></div>
</td>

<td><%=p.getCategoryName()%></td>

<td>
RM <%=p.getPrice()%>
<% if (p.getIsOnSale()==1 && p.getSalePrice()!=null) { %>
<div class="muted">Sale RM <b><%=p.getSalePrice()%></b></div>
<% } %>
</td>

<td>
<%= p.getIsActive()==1 ? "<span class='pill pill-on'>ACTIVE</span>" : "<span class='pill pill-off'>INACTIVE</span>" %>
<br><br>
<%= p.getIsHighlight()==1 ? "<span class='pill pill-on'>HIGHLIGHT</span>" : "<span class='pill pill-off'>NO HIGHLIGHT</span>" %>
<br><br>
<%= p.getIsOnSale()==1 ? "<span class='pill pill-on'>ON SALE</span>" : "<span class='pill pill-off'>NO SALE</span>" %>
</td>

<td>
<div class="actions">

<form method="post" action="<%=request.getContextPath()%>/admin/products">
<input type="hidden" name="action" value="toggleActive">
<input type="hidden" name="id" value="<%=p.getId()%>">
<input type="hidden" name="isActive" value="<%=p.getIsActive()==1?0:1%>">
<button class="btn btn-sm">Toggle Active</button>
</form>

<form method="post" action="<%=request.getContextPath()%>/admin/products">
<input type="hidden" name="action" value="toggleHighlight">
<input type="hidden" name="id" value="<%=p.getId()%>">
<input type="hidden" name="isHighlight" value="<%=p.getIsHighlight()==1?0:1%>">
<button class="btn btn-sm btn-primary">Highlight</button>
</form>

<form method="post" action="<%=request.getContextPath()%>/admin/products">
<input type="hidden" name="action" value="delete">
<input type="hidden" name="id" value="<%=p.getId()%>">
<button class="btn btn-sm">Delete</button>
</form>

</div>
</td>
</tr>
<% } %>
</table>

<% } %>

</div>

</body>
</html>
