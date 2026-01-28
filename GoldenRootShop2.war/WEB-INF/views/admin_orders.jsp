<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Order" %>

<!DOCTYPE html>
<html>
<head>
  <title>Admin Orders</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

  <style>
    :root{
      --orange:#f57c00;
      --orange-dark:#ef6c00;
      --border:rgba(0,0,0,.08);
      --shadow:0 12px 32px rgba(0,0,0,.08);
    }

    body{
      background:#fafafa;
      font-family:'Segoe UI',system-ui,-apple-system;
    }

    h2,h3{ font-weight:950; }

    /* ================= ADMIN NAV ================= */
    .admin-nav{
      display:flex;
      gap:14px;
      flex-wrap:wrap;
      margin:16px 0 24px;
    }

    .admin-nav a{
      padding:14px 26px;
      border-radius:999px;
      font-weight:950;
      text-decoration:none;
      color:#fff;
      background:linear-gradient(135deg,#ff9800,#f57c00);
      box-shadow:0 10px 24px rgba(245,124,0,.35);
      transition:.25s;
    }

    .admin-nav a:hover{
      transform:translateY(-3px);
      background:linear-gradient(135deg,#ffa726,#ef6c00);
      box-shadow:0 18px 36px rgba(245,124,0,.45);
    }

    /* ================= CARD ================= */
    .card{
      background:#fff;
      border-radius:18px;
      border:1px solid var(--border);
      box-shadow:var(--shadow);
      padding:20px;
    }

    /* ================= TABLE ================= */
    .table{
      width:100%;
      border-collapse:collapse;
    }

    .table th{
      background:#fff8f1;
      color:var(--orange);
      font-weight:950;
      padding:14px;
      border-bottom:2px solid #ffe0b2;
      text-align:left;
    }

    .table td{
      padding:14px;
      border-bottom:1px solid #eee;
      vertical-align:top;
    }

    .table tr:hover{
      background:#fffdf9;
    }

    .muted{ opacity:.75; }
    .small{ font-size:13px; }

    /* ================= CHIP ================= */
    .chip{
      display:inline-flex;
      align-items:center;
      padding:6px 12px;
      border-radius:999px;
      font-weight:900;
      font-size:12px;
      border:1px solid #eee;
      background:#f7f7f7;
    }
    .chip.orange{ background:#fff3e0; color:#f57c00; border-color:#ffe0b2; }
    .chip.green{ background:#e8f5e9; color:#2e7d32; border-color:#c8e6c9; }
    .chip.red{ background:#ffebee; color:#c62828; border-color:#ffcdd2; }
    .chip.blue{ background:#e3f2fd; color:#1565c0; border-color:#bbdefb; }

    /* ================= BUTTON ================= */
    .btn{
      padding:10px 18px;
      border-radius:999px;
      border:none;
      font-weight:900;
      cursor:pointer;
      background:#fff3e0;
      color:#e65100;
      transition:.2s;
    }

    .btn:hover{
      background:var(--orange);
      color:#fff;
      transform:translateY(-1px);
      box-shadow:0 10px 22px rgba(245,124,0,.35);
    }

    .btn-primary{
      background:linear-gradient(135deg,#ff9800,#f57c00);
      color:#fff;
    }

    .btn-primary:hover{
      background:linear-gradient(135deg,#ffa726,#ef6c00);
    }

    .btn-danger{
      background:#ffebee;
      color:#c62828;
      border:1px solid #ffcdd2;
    }

    .btn-danger:hover{
      background:#e53935;
      color:#fff;
      box-shadow:0 10px 22px rgba(229,57,53,.35);
    }

    .btn-ghost{
      background:#fff;
      border:1px solid #ddd;
      color:#333;
    }

    .btn-ghost:hover{
      background:#f5f5f5;
    }

    .actions{
      display:flex;
      gap:8px;
      flex-wrap:wrap;
    }

    /* ================= NOTE ================= */
    .note{
      padding:12px 14px;
      border-radius:14px;
      border:1px solid #eee;
      background:#fafafa;
      margin-top:8px;
    }
    .note.warn{ background:#fff7ed; border-color:#ffedd5; }
    .note.danger{ background:#fff1f2; border-color:#ffe4e6; }

    details.box{
      margin-top:8px;
      border:1px dashed #eee;
      border-radius:12px;
      padding:10px 12px;
      background:#fff;
    }
    details.box summary{
      cursor:pointer;
      font-weight:900;
      list-style:none;
    }
    details.box summary::-webkit-details-marker{ display:none; }
  </style>
</head>

<body>

<div class="container" style="padding:24px 0;">
  <h2 style="color:#f57c00;margin:0;">Admin Orders</h2>

  <!-- ✅ VIEW ORDERS BUTTON DIBUANG -->
  <div class="admin-nav">
    <a href="<%=request.getContextPath()%>/admin/dashboard">Dashboard</a>
    <a href="<%=request.getContextPath()%>/admin/products">Manage Products</a>
    <a href="<%=request.getContextPath()%>/admin/logout">Logout</a>
  </div>
</div>

<div class="container">

<div class="card" style="margin-bottom:14px;">
  <div style="display:flex;justify-content:space-between;align-items:center;">
    <div>
      <h3 style="margin:0;">Orders List</h3>
      <div class="muted" style="margin-top:6px;">
        Manage shipping, completion, cancellations & return/refund requests.
      </div>
    </div>
    <span class="chip orange">Live</span>
  </div>
</div>

<div class="card">
<%
  List<Order> orders = (List<Order>) request.getAttribute("orders");
%>

<% if (orders == null || orders.isEmpty()) { %>
  <div class="note">
    <b>No orders yet.</b>
    <div class="muted">Orders will appear after customer checkout.</div>
  </div>
<% } else { %>

<table class="table">
<tr>
  <th>Order</th>
  <th>Shipping Details</th>
  <th>Total</th>
  <th>Status</th>
  <th>Actions</th>
</tr>

<% for (Order o : orders) {

  String status = (o.getStatus()==null?"":o.getStatus().toUpperCase());
  String statusChip="chip";
  if("COMPLETED".equals(status)) statusChip="chip green";
  else if("CANCELLED".equals(status)||"REFUNDED".equals(status)) statusChip="chip red";
  else if("SHIPPED".equals(status)||"TO_RECEIVE".equals(status)) statusChip="chip blue";

  boolean cancelReq = o.getCancelRequested()==1;
  boolean returnReq = o.getReturnRequested()==1;
%>

<tr>
<td>
  <b>#<%=o.getId()%></b>
  <div class="muted small"><%=o.getCreatedAt()%></div>
  <% if(cancelReq){ %><span class="chip red">Cancel Request</span><% } %>
  <% if(returnReq){ %><span class="chip orange">Return Request</span><% } %>
</td>

<td>
  <b><%=o.getRecipientName()%></b>
  <div class="muted small">Phone: <%=o.getPhone()%></div>

  <details class="box">
    <summary>View address</summary>
    <div class="note"><%=o.getFullAddress()%></div>
  </details>

  <% if(cancelReq){ %>
    <div class="note danger"><b>Cancel reason:</b> <%=o.getCancelReason()%></div>
  <% } %>

  <% if(returnReq){ %>
    <div class="note warn"><b>Return reason:</b> <%=o.getReturnReason()%></div>
  <% } %>
</td>

<td>
  <b>RM <%=o.getTotalAmount()%></b>
  <div class="muted small">Payment: <%=o.getPaymentMethod()%></div>
</td>

<td>
  <span class="<%=statusChip%>"><%=status%></span>
</td>

<td>
<form method="post" action="<%=request.getContextPath()%>/admin/orders">
<input type="hidden" name="orderId" value="<%=o.getId()%>">

<div class="actions">

<% if("PROCESSING".equals(status)||"TO_RECEIVE".equals(status)){ %>
<button class="btn btn-primary" name="action" value="SHIP">Ship</button>
<% } %>

<% if("SHIPPED".equals(status)||"TO_RECEIVE".equals(status)){ %>
<button class="btn" name="action" value="COMPLETE">Complete</button>
<% } %>

<% if(cancelReq){ %>
<button class="btn btn-danger" name="action" value="APPROVE_CANCEL">Approve Cancel</button>
<button class="btn btn-ghost" name="action" value="REJECT_CANCEL">Reject Cancel</button>
<% } %>

<% if(returnReq){ %>
<button class="btn btn-danger" name="action" value="APPROVE_RETURN">Approve Return</button>
<button class="btn btn-ghost" name="action" value="REJECT_RETURN">Reject Return</button>
<button class="btn" name="action" value="REFUND">Refund</button>
<% } %>

</div>
</form>
</td>
</tr>

<% } %>
</table>
<% } %>

</div>
</div>

</body>
</html>
