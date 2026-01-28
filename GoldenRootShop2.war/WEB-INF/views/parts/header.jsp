<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>

<%
    String contextPath = request.getContextPath();          // contoh: /GoldenRootShop
    String uri = request.getRequestURI();                   // contoh: /GoldenRootShop/products

    // buang contextPath -> /products
    String path = uri.substring(contextPath.length());
    if (path == null || path.isEmpty()) path = "/";

    // buang trailing slash jika ada
    if (path.endsWith("/") && path.length() > 1) {
        path = path.substring(0, path.length() - 1);
    }

    // ambil endpoint terakhir -> products / home / our-story / purchases
    String current = path;
    if (current.contains("/")) {
        current = current.substring(current.lastIndexOf("/") + 1);
    }
%>

<style>
  .top-announcement{
    background: orange;
    color: #fff;
    text-align: center;
    padding: 10px 18px;
    font-weight: 700;
  }

  .header{
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding: 18px 40px;
    border-bottom:1px solid #eee;
    background:#fff;
  }

  .logo{
    font-size: 34px;
    font-weight: 900;
    color: orange;
    letter-spacing: .5px;
  }

  .nav{
    display:flex;
    align-items:center;
    gap: 28px;
  }

  .nav a{
    text-decoration:none;
    color:#222;
    font-weight:800;
    padding: 6px 2px;
    border-bottom: 2px solid transparent;
  }

  /* ✅ ACTIVE NAV = OREN */
  .nav a.active{
    color: orange;
    border-bottom: 2px solid orange;
  }

  .nav a:hover{
    color: orange;
  }

  .header-right{
    display:flex;
    align-items:center;
    gap: 14px;
  }

  .login-link{
    text-decoration:none;
    color:#222;
    font-weight:800;
  }

  .login-link:hover{
    color: orange;
  }

  .hi{
    font-weight:800;
    color:#222;
  }

  .badge{
    font-size: 22px;
    text-decoration:none;
    line-height:1;
  }
</style>

<div class="top-announcement">
  Buy Now to Get Special Offer and Discount
</div>

<div class="header">
  <div class="logo">Golden Root</div>

  <div class="nav">
    <a href="<%=contextPath%>/home"
       class="<%= "home".equals(current) ? "active" : "" %>">HOME</a>

    <a href="<%=contextPath%>/products"
       class="<%= "products".equals(current) ? "active" : "" %>">PRODUCT</a>

    <a href="<%=contextPath%>/our-story"
       class="<%= "our-story".equals(current) ? "active" : "" %>">OUR STORY</a>

    <a href="<%=contextPath%>/purchases?tab=all"
       class="<%= "purchases".equals(current) ? "active" : "" %>">MY PURCHASE</a>
  </div>

  <div class="header-right">
    <%
      User u = (User) session.getAttribute("user");
      if (u == null) {
    %>
        <a href="<%=contextPath%>/login" class="login-link">Login</a>
    <%
      } else {
    %>
        <span class="hi">Hi, <%=u.getFullName()%></span>
        <a href="<%=contextPath%>/logout" class="login-link">Logout</a>
    <%
      }
    %>

    <!-- ✅ CART ICON -->
    <a class="badge" href="<%=contextPath%>/cart">🛒</a>
  </div>
</div>
