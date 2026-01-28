<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Address" %>
<!DOCTYPE html>
<html>
<head>
  <title>Checkout</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
  <link rel="stylesheet" href="css/footer.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>


<body>

<jsp:include page="parts/header.jsp"/>

<div class="container">
  <h2 style="margin:16px 0;">Checkout</h2>

  <%
    Address def = (Address) request.getAttribute("defaultAddress");
  %>

  <div class="card" style="padding:18px;">
    <form method="post" action="<%=request.getContextPath()%>/checkout">

      <h3 style="margin:0 0 10px 0;">Shipping Address</h3>

      <label>Recipient Name</label><br/>
      <input name="recipient" style="width:100%;max-width:520px;"
             value="<%= def!=null ? def.getRecipientName() : "" %>" required><br/><br/>

      <label>Phone</label><br/>
      <input name="phone" style="width:100%;max-width:520px;"
             value="<%= def!=null ? def.getPhone() : "" %>" required><br/><br/>

      <label>Address Line 1</label><br/>
      <input name="line1" style="width:100%;max-width:680px;"
             value="<%= def!=null ? def.getAddressLine1() : "" %>" required><br/><br/>

      <label>Address Line 2 (optional)</label><br/>
      <input name="line2" style="width:100%;max-width:680px;"
             value="<%= def!=null ? (def.getAddressLine2()==null?"":def.getAddressLine2()) : "" %>"><br/><br/>

      <div style="display:flex; gap:12px; flex-wrap:wrap;">
        <div>
          <label>City</label><br/>
          <input name="city" value="<%= def!=null ? def.getCity() : "" %>" required>
        </div>
        <div>
          <label>State</label><br/>
          <input name="state" value="<%= def!=null ? def.getState() : "" %>" required>
        </div>
        <div>
          <label>Postcode</label><br/>
          <input name="postcode" value="<%= def!=null ? def.getPostcode() : "" %>" required>
        </div>
      </div>

      <div style="height:14px;"></div>

      <h3 style="margin:0 0 10px 0;">Payment Method</h3>
      <select name="payment" required>
        <option value="COD">Cash On Delivery (COD)</option>
        <option value="FPX">Online Banking (FPX)</option>
        <option value="CARD">Debit/Credit Card</option>
      </select>

      <div style="height:18px;"></div>

      <button class="btn btn-primary" type="submit">Place Order</button>
      <a class="btn" href="<%=request.getContextPath()%>/cart" style="margin-left:8px;">Back to Cart</a>

    </form>
  </div>
</div>
<script src="<%=request.getContextPath()%>/js/footer.js"></script>

<jsp:include page="parts/footer.jsp" />



</body>
</html>
