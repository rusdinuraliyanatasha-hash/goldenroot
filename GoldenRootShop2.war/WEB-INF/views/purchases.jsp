<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.math.BigDecimal" %>
<%@ page import="model.PurchaseRow" %>
<!DOCTYPE html>
<html>
<head>
  <title>My Purchases</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

  <style>
    .order-card{ padding:16px; }
    .order-top{ display:flex; justify-content:space-between; gap:12px; flex-wrap:wrap; align-items:flex-start; }
    .order-status{ font-weight:900; }
    .order-meta{ margin-top:6px; }
    .pill{
      display:inline-flex; align-items:center; gap:8px;
      padding:6px 10px; border-radius:999px;
      background:#fff3e6; font-weight:900; font-size:12px;
      border:1px solid #f1e3d3;
    }
    .items{ margin-top:12px; display:flex; flex-direction:column; gap:10px; }
    .item{
      display:flex; gap:12px; align-items:center;
      border:1px solid #eee; border-radius:14px; padding:10px;
      background:#fff;
    }
    .item-img{
      width:70px; height:70px; border-radius:12px;
      object-fit:cover; background:#fafafa; border:1px solid #eee;
      flex:0 0 auto;
    }
    .item-mid{ flex:1; min-width:180px; }
    .item-name{ font-weight:900; margin:0 0 4px 0; }
    .item-sub{ font-size:13px; }
    .item-right{ text-align:right; min-width:120px; }
    .item-right .price{ font-weight:900; color:var(--orange); }
    .item-right .qty{ font-size:13px; color:var(--gray); }
    .order-bottom{
      margin-top:12px;
      display:flex; justify-content:space-between; gap:12px; flex-wrap:wrap; align-items:center;
    }
    .addr{ font-size:13px; line-height:1.5; }
    .actions form{ display:flex; gap:8px; flex-wrap:wrap; margin:0; }
    .actions input[type="text"]{
      padding:10px 12px; border-radius:12px; border:1px solid #ddd; outline:none;
      min-width:240px;
    }
  </style>
</head>

<body>

<jsp:include page="parts/header.jsp"/>

<div class="container">
  <h2 style="margin:16px 0;">My Purchases</h2>

  <%
    String tab = (String) request.getAttribute("tab");
    if (tab == null) tab = "all";

    List<PurchaseRow> rows = (List<PurchaseRow>) request.getAttribute("rows");
    if (rows == null) rows = new ArrayList<>();

    String err = request.getParameter("err");
  %>

  <% if (err != null) { %>
    <div class="card" style="padding:12px; margin-bottom:12px; border:1px solid #ffd9d9;">
      <b style="color:#c00;">Notice:</b>
      <% if ("cancel_time".equals(err)) { %>
        Cancellation only can be made within <b>1 hour</b> after checkout.
      <% } else if ("return_time".equals(err)) { %>
        Return/Refund only can be made within <b>3 days</b> (after order completed/delivered).
      <% } else { %>
        Action not allowed.
      <% } %>
    </div>
  <% } %>

  <!-- tabs -->
  <div style="display:flex; gap:10px; flex-wrap:wrap; margin-bottom:14px;">
    <a class="btn <%= "all".equals(tab)?"btn-primary":"" %>" href="<%=request.getContextPath()%>/purchases?tab=all">All</a>
    <a class="btn <%= "to_receive".equals(tab)?"btn-primary":"" %>" href="<%=request.getContextPath()%>/purchases?tab=to_receive">To Receive</a>
    <a class="btn <%= "complete".equals(tab)?"btn-primary":"" %>" href="<%=request.getContextPath()%>/purchases?tab=complete">Complete</a>
    <a class="btn <%= "return".equals(tab)?"btn-primary":"" %>" href="<%=request.getContextPath()%>/purchases?tab=return">Return/Refund</a>
    <a class="btn <%= "cancel".equals(tab)?"btn-primary":"" %>" href="<%=request.getContextPath()%>/purchases?tab=cancel">Cancel</a>
  </div>

  <% if (rows.isEmpty()) { %>
    <div class="card" style="padding:18px;">No orders.</div>
  <% } else { %>

    <%
      LinkedHashMap<Integer, List<PurchaseRow>> byOrder = new LinkedHashMap<>();
      for (PurchaseRow r : rows) {
        byOrder.computeIfAbsent(r.getOrderId(), k -> new ArrayList<>()).add(r);
      }
    %>

    <div style="display:flex; flex-direction:column; gap:14px;">
      <% for (Map.Entry<Integer, List<PurchaseRow>> e : byOrder.entrySet()) {
           List<PurchaseRow> items = e.getValue();
           PurchaseRow o = items.get(0);
           String ad = (o.getAdminDecision()==null ? "" : o.getAdminDecision().toUpperCase());
           boolean cancelReq = (o.getCancelRequested() == 1);
           boolean returnReq = (o.getReturnRequested() == 1);

           boolean alreadyReturnFlow =
               returnReq ||
               ad.contains("RETURN_") ||
               "REFUNDED".equalsIgnoreCase(o.getStatus());
      %>

        <div class="card order-card">
          <div class="order-top">
            <div>
              <div class="order-status">
                <span class="pill"><i class="fa-solid fa-receipt"></i> <%=o.getStatus()%></span>
                <span class="muted" style="margin-left:10px;"><%=o.getCreatedAt()%></span>
              </div>

              <div class="order-meta muted">
                Payment: <b><%=o.getPaymentMethod()%></b> |
                Total: <b>RM <%=o.getTotalAmount()%></b>
              </div>
            </div>

            <div class="addr muted">
              <b>Deliver to:</b> <%=o.getRecipientName()%> - <%=o.getPhone()%><br/>
              <%=o.getFullAddress()%>
            </div>
          </div>

          <!-- items -->
          <div class="items">
            <% for (PurchaseRow it : items) { %>
              <div class="item">
                <img class="item-img"
                     src="<%=request.getContextPath()%>/<%=it.getImageUrl()%>"
                     alt="">
                <div class="item-mid">
                  <div class="item-name"><%=it.getProductName()%></div>
                  <div class="item-sub muted">Unit price: RM <%=it.getItemPrice()%></div>
                </div>
                <div class="item-right">
                  <div class="qty">Qty: <b><%=it.getQty()%></b></div>
                  <div class="price">
                    RM
                    <%
                      BigDecimal line = (it.getItemPrice() == null ? BigDecimal.ZERO : it.getItemPrice())
                                       .multiply(new BigDecimal(it.getQty()));
                    %>
                    <%=line%>
                  </div>
                </div>
              </div>
            <% } %>
          </div>

          <!-- actions -->
          <div class="order-bottom">
            <div class="actions">

              <%-- Cancel Request (within 1 hour) --%>
              <% if ("TO_RECEIVE".equalsIgnoreCase(o.getStatus()) && !cancelReq) { %>
                <form method="post" action="<%=request.getContextPath()%>/order/cancel"
                      onsubmit="return confirm('Cancellation Policy:\\n- Cancel hanya boleh dibuat dalam 1 jam selepas purchase.\\n\\nTeruskan?');">
                  <input type="hidden" name="orderId" value="<%=o.getOrderId()%>">
                  <input type="text" name="reason" placeholder="Cancel reason" required>
                  <button class="btn" type="submit">Request Cancel</button>
                </form>
              <% } %>

              <%-- Return/Refund Request --%>
              <% if ("COMPLETED".equalsIgnoreCase(o.getStatus()) && !alreadyReturnFlow) { %>
                <form method="post" action="<%=request.getContextPath()%>/order/return"
                      onsubmit="return confirm('Return/Refund Policy:\\n- Refund requests can only be made within 3 days after the product is delivered.\\n\\nProceed?');">
                  <input type="hidden" name="orderId" value="<%=o.getOrderId()%>">
                  <input type="text" name="reason" placeholder="Return/Refund reason" required>
                  <button class="btn" type="submit">Request Return/Refund</button>
                </form>
              <% } %>

              <%-- Status texts --%>
              <% if (cancelReq) { %>
                <div class="muted" style="margin-top:8px;">
                  Cancel requested: <%= (o.getCancelReason()==null ? "-" : o.getCancelReason()) %>
                  <% if (o.getAdminDecision() != null) { %>
                    | Admin: <b><%=o.getAdminDecision()%></b>
                  <% } %>
                </div>
              <% } %>

              <% if (returnReq || ad.contains("RETURN_") || "REFUNDED".equalsIgnoreCase(o.getStatus())) { %>
                <div class="muted" style="margin-top:8px;">
                  Return/Refund: 
                  <% if (returnReq || ad.contains("RETURN_REQUESTED")) { %>
                    <b>REQUESTED</b>
                  <% } else if (ad.contains("RETURN_APPROVED")) { %>
                    <b>APPROVED</b>
                  <% } else if (ad.contains("RETURN_REJECTED")) { %>
                    <b>REJECTED</b>
                  <% } else if ("REFUNDED".equalsIgnoreCase(o.getStatus()) || ad.contains("RETURN_REFUNDED")) { %>
                    <b>REFUNDED</b>
                  <% } else { %>
                    <b><%=o.getAdminDecision()%></b>
                  <% } %>
                  <% if (o.getReturnReason() != null) { %>
                    | Reason: <b><%=o.getReturnReason()%></b>
                  <% } %>
                </div>
              <% } %>

            </div>
          </div>

        </div>
      <% } %>
    </div>

  <% } %>

</div>

<script src="<%=request.getContextPath()%>/js/footer.js"></script>
<jsp:include page="parts/footer.jsp" />

</body>
</html>
