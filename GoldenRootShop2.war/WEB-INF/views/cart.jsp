<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, java.math.BigDecimal, model.CartItem" %>
<!DOCTYPE html>
<html>
<head>
  <title>Your Cart</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
  <link rel="stylesheet" href="css/footer.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<jsp:include page="parts/header.jsp"/>

<div class="container">
  <h2 class="section-title">Your Cart</h2>

  <%
    List<CartItem> items = (List<CartItem>) request.getAttribute("items");
    BigDecimal total = (BigDecimal) request.getAttribute("total");
  %>

  <div class="card" style="padding:16px;">
    <% if (items == null || items.isEmpty()) { %>
      <p class="muted">Your cart is empty.</p>
      <a class="btn btn-primary" href="<%=request.getContextPath()%>/products">Continue Shopping</a>
    <% } else { %>

      <table style="width:100%; border-collapse:collapse;">
        <tr style="text-align:left;">
          <th>Item</th>
          <th>Price</th>
          <th>Qty</th>
          <th>Total</th>
          <th></th>
        </tr>

        <% for (CartItem c : items) { %>
        <tr style="border-top:1px solid #eee;">
          <td style="padding:10px 0;">
            <div style="display:flex; gap:12px; align-items:center;">
              <img src="<%=request.getContextPath()%>/<%=c.getImageUrl()%>"
                   style="width:60px;height:60px;object-fit:contain;background:#fff3e0;border-radius:10px;">
              <div>
                <div style="font-weight:900;"><%=c.getProductName()%></div>
              </div>
            </div>
          </td>

          <td>RM <%=c.getPrice()%></td>

          <td>
            <form method="post" action="<%=request.getContextPath()%>/cart" style="display:flex; gap:8px; align-items:center;">
              <input type="hidden" name="action" value="update">
              <input type="hidden" name="id" value="<%=c.getId()%>">
              <input type="number" name="qty" min="1" value="<%=c.getQty()%>" style="width:70px;">
              <button class="btn btn-primary" type="submit">Update</button>
            </form>
          </td>

          <td style="font-weight:900;">RM <%=c.getLineTotal()%></td>

          <td>
            <form method="post" action="<%=request.getContextPath()%>/cart">
              <input type="hidden" name="action" value="delete">
              <input type="hidden" name="id" value="<%=c.getId()%>">
              <button class="btn" type="submit" style="background:#eee;">Remove</button>
            </form>
          </td>
        </tr>
        <% } %>
      </table>

      <div style="display:flex; justify-content:space-between; align-items:center; margin-top:16px;">
        <div class="muted">Grand Total</div>
        <div style="font-weight:900; font-size:18px; color:var(--orange);">RM <%=total%></div>
      </div>

      <div style="margin-top:14px; display:flex; gap:10px;">
        <a class="btn" href="<%=request.getContextPath()%>/products" style="background:#eee;">Continue Shopping</a>
        <a class="btn btn-primary" href="<%=request.getContextPath()%>/checkout">Checkout</a>
      </div>

    <% } %>
  </div>
</div>

<script src="<%=request.getContextPath()%>/js/footer.js"></script>

<jsp:include page="parts/footer.jsp" />

</body>
</html>
