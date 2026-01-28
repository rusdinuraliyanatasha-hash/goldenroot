<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Category, model.Product" %>
<!DOCTYPE html>
<html>
<head>
  <title>Products</title>

  <!-- keep your original css (header/footer) -->
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

  <!-- ✅ Products page CSS only here -->
  <style>
    :root{
      --orange:#f57c00;
      --orange2:#ff8a00;
      --cream:#fff7ee;
      --bg:#fff3e8;
      --text:#111;
      --muted:#6f6f6f;
      --border:#f0e3d8;
      --card:#ffffff;
      --shadow:0 14px 34px rgba(0,0,0,.10);
      --radius:18px;
      --green:#2e7d32;
      --green2:#43a047;
    }

    .p-wrap{width:92%;max-width:1200px;margin:16px auto;}
    .p-breadcrumb{display:flex;gap:8px;align-items:center;color:#777;font-weight:800;margin:8px 2px 14px;}
    .p-breadcrumb a{color:#666}
    .p-breadcrumb i{font-size:12px;opacity:.7}

    .p-layout{
      display:grid;
      grid-template-columns: 280px 1fr;
      gap: 18px;
      align-items:start;
    }

    /* ===== left filter ===== */
    .p-filter{
      background: linear-gradient(180deg,#fff9f4,#fff);
      border:1px solid var(--border);
      border-radius: 18px;
      box-shadow: 0 10px 26px rgba(0,0,0,.06);
      padding: 14px;
      position: sticky;
      top: 14px;
    }
    .p-filter h3{
      margin:0 0 12px;
      font-size:18px;
      font-weight:900;
      display:flex;
      gap:10px;
      align-items:center;
      color:#2b2b2b;
    }
    .p-filter h3 i{color:var(--green)}
    .f-block{border-top:1px solid #f3e7dc;padding-top:12px;margin-top:12px;}
    .f-title{font-weight:900;margin:0 0 10px;color:#333;}
    .cat-list{list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:8px;}
    .cat-item a{
      display:flex;justify-content:space-between;align-items:center;
      padding:10px 12px;
      border-radius:14px;
      border:1px solid #f2e3d6;
      background:#fff;
      font-weight:900;
      color:#333;
      transition: .15s ease;
    }
    .cat-item a:hover{transform: translateY(-1px); box-shadow:0 10px 18px rgba(0,0,0,.06);}
    .cat-item a.active{
      background: linear-gradient(135deg, var(--orange2), var(--orange));
      color:#fff;
      border-color: transparent;
    }

    .price-row{display:flex;gap:10px;align-items:center;justify-content:space-between;}
    .price-box{
      flex:1;
      border:1px solid #f2e3d6;
      border-radius:12px;
      padding:10px 10px;
      background:#fff;
      font-weight:900;
      color:#333;
      text-align:center;
    }
    .range{
      width:100%;
      margin:10px 0 8px;
      accent-color: var(--green2);
    }
    .btn-filter{
      width:100%;
      border:none;
      cursor:pointer;
      border-radius:14px;
      padding:12px 14px;
      font-weight:900;
      background: linear-gradient(135deg, var(--green2), var(--green));
      color:#fff;
      box-shadow:0 14px 28px rgba(46,125,50,.18);
    }
    .btn-filter:hover{filter:brightness(.97);}

    /* ===== right content ===== */
    .p-hero{
      background: linear-gradient(135deg,#fff2e4,#fff);
      border:1px solid var(--border);
      border-radius: 18px;
      box-shadow: var(--shadow);
      overflow:hidden;
      padding: 16px 18px;
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:16px;
      min-height: 110px;
      position: relative;
    }
    .p-hero:after{
      content:"";
      position:absolute; inset:0;
      background: radial-gradient(circle at 70% 30%, rgba(245,124,0,.16), transparent 55%);
      pointer-events:none;
    }
    .p-hero-left{position:relative; z-index:1;}
    .p-hero-title{margin:0;font-size:34px;font-weight:900;color:var(--orange);}
    .p-hero-sub{margin:6px 0 0;font-weight:900;color:#555;opacity:.9;}
    .p-hero-img{
      position:relative; z-index:1;
      width: 220px; height: 90px;
      border-radius:14px;
      border:1px dashed #f0d8c7;
      background:#fff;
      display:flex;
      align-items:center;
      justify-content:center;
      font-weight:900;
      color:#c3a28c;
    }

    .p-toolbar{
      margin-top: 12px;
      background:#fff;
      border:1px solid var(--border);
      border-radius: 14px;
      padding: 10px 12px;
      box-shadow: 0 10px 22px rgba(0,0,0,.05);
      display:flex;
      align-items:center;
      justify-content:space-between;
      gap:12px;
      flex-wrap:wrap;
    }
    .p-count{
      font-weight:900;
      color:#3b3b3b;
      display:flex;
      gap:10px;
      align-items:center;
    }
    .p-count .dot{
      width:10px;height:10px;border-radius:99px;background:var(--green2);
      box-shadow:0 6px 14px rgba(67,160,71,.25);
    }

    .p-sort{
      display:flex;
      gap:10px;
      align-items:center;
      flex-wrap:wrap;
      font-weight:900;
      color:#444;
    }
    .p-sort a{
      padding:8px 10px;
      border-radius:12px;
      border:1px solid #f2e3d6;
      background:#fff;
    }
    .p-sort a:hover{background:#fff7f0}
    .p-sort a.active{
      background: linear-gradient(135deg,var(--orange2),var(--orange));
      color:#fff;border-color:transparent;
    }

    /* product grid */
    .p-grid{
      margin-top: 14px;
      display:grid;
      grid-template-columns: repeat(3, 1fr);
      gap: 16px;
    }

    .p-card{
      background: var(--card);
      border:1px solid #f2e3d6;
      border-radius: 18px;
      overflow:hidden;
      box-shadow: 0 12px 26px rgba(0,0,0,.08);
      display:flex;
      flex-direction:column;
      height:100%;
      transition: transform .16s ease, box-shadow .16s ease;
      position: relative;
    }
    .p-card:hover{
      transform: translateY(-5px);
      box-shadow: 0 18px 45px rgba(0,0,0,.12);
    }

    .p-img{
      height: 190px;
      background: linear-gradient(180deg, #fff7ee, #fff);
      display:flex;
      align-items:center;
      justify-content:center;
      padding: 12px;
      position: relative;
    }

    .p-img img{
      width:100%;
      height:100%;
      object-fit:contain;
      display:block;
    }

    /* wishlist heart */
    .wish{
      position:absolute;
      top: 10px;
      left: 10px;
      width:34px;height:34px;
      border-radius:999px;
      background: rgba(255,255,255,.92);
      border:1px solid #f0e0d1;
      display:flex;align-items:center;justify-content:center;
      box-shadow:0 10px 18px rgba(0,0,0,.08);
      color:#ff7a00;
      z-index:2;
    }

    /* popular tag */
    .tag{
      position:absolute;
      top: 10px;
      right: 10px;
      padding:7px 10px;
      border-radius:999px;
      font-weight:900;
      font-size:12px;
      background: linear-gradient(135deg, var(--green2), var(--green));
      color:#fff;
      z-index:2;
      box-shadow:0 12px 22px rgba(46,125,50,.18);
    }

    .p-body{
      padding: 12px 12px 14px;
      display:flex;
      flex-direction:column;
      gap: 8px;
      flex: 1;
    }

    .p-name{
      font-weight:900;
      line-height:1.25;
      /* clamp 3 lines for nice UI */
      display:-webkit-box;
      -webkit-line-clamp:3;
      -webkit-box-orient:vertical;
      overflow:hidden;
    }

    .p-rating{
      display:flex;
      align-items:center;
      gap:8px;
      font-weight:900;
      color:#777;
      font-size:13px;
    }
    .stars{color:#ff9800;}
    .p-cat{font-weight:900;color:#8a8a8a;font-size:13px;}

    .p-bottom{
      margin-top:auto;
      display:flex;
      justify-content:space-between;
      align-items:center;
      gap:10px;
      padding-top: 8px;
    }

    .p-price{font-weight:900;color:#ff6f00;}
    .btn-buy{
      border:none; cursor:pointer;
      border-radius: 12px;
      padding: 10px 14px;
      font-weight:900;
      background: linear-gradient(135deg, var(--green2), var(--green));
      color:#fff;
      box-shadow:0 14px 28px rgba(46,125,50,.18);
      white-space:nowrap;
    }
    .btn-buy:hover{filter:brightness(.97);}

    /* responsive */
    @media (max-width: 1080px){
      .p-layout{grid-template-columns:1fr;}
      .p-filter{position:relative; top:auto;}
      .p-grid{grid-template-columns:repeat(2,1fr);}
      .p-hero{flex-direction:column; align-items:flex-start;}
      .p-hero-img{width:100%;}
    }
    @media (max-width: 560px){
      .p-grid{grid-template-columns:1fr;}
      .p-hero-title{font-size:28px;}
    }
  </style>
</head>

<body>
<jsp:include page="parts/header.jsp"/>

<div class="p-wrap">

  <!-- breadcrumb -->
  <div class="p-breadcrumb">
    <a href="<%=request.getContextPath()%>/home">Home</a>
    <i class="fa-solid fa-chevron-right"></i>
    <span>Products</span>
  </div>

  <div class="p-layout">

    <!-- LEFT: FILTER -->
    <aside class="p-filter">
      <h3><i class="fa-solid fa-filter"></i> Filter Product</h3>

      <!-- Categories -->
      <div class="f-block">
        <div class="f-title">All Categories</div>

        <ul class="cat-list">
          <%
            List<Category> cats = (List<Category>) request.getAttribute("categories");
            Integer sel = (Integer) request.getAttribute("selectedCategoryId");
            boolean allActive = (sel == null);
          %>

          <li class="cat-item">
            <a class="<%= allActive ? "active" : "" %>"
               href="<%=request.getContextPath()%>/products">
              All
              <span><i class="fa-solid fa-angle-right"></i></span>
            </a>
          </li>

          <%
            if (cats != null) {
              for (Category c : cats) {
                boolean selected = (sel != null && sel.intValue() == c.getId());
          %>
            <li class="cat-item">
              <a class="<%= selected ? "active" : "" %>"
                 href="<%=request.getContextPath()%>/products?categoryId=<%=c.getId()%>">
                <%=c.getName()%>
                <span><i class="fa-solid fa-angle-right"></i></span>
              </a>
            </li>
          <%
              }
            }
          %>
        </ul>
      </div>

      <!-- ✅ Price (CONNECTED TO BACKEND) -->
      <div class="f-block">
        <div class="f-title">Filter Price</div>

        <form method="get" action="<%=request.getContextPath()%>/products" id="priceForm">
          <%
            // keep categoryId when applying price filter
            if (sel != null) {
          %>
            <input type="hidden" name="categoryId" value="<%=sel%>">
          <%
            }

            Integer minPriceAttr = (Integer) request.getAttribute("minPrice");
            Integer maxPriceAttr = (Integer) request.getAttribute("maxPrice");

            int minV = (minPriceAttr == null ? 0 : minPriceAttr);
            int maxV = (maxPriceAttr == null ? 600 : maxPriceAttr);
          %>

          <!-- backend reads these -->
          <input type="hidden" name="minPrice" id="minPriceInput" value="<%=minV%>">
          <input type="hidden" name="maxPrice" id="maxPriceInput" value="<%=maxV%>">

          <input class="range" type="range" min="0" max="1000" value="<%=maxV%>" id="priceRange">

          <div class="price-row">
            <div class="price-box" id="minPriceBox">RM <%=minV%></div>
            <div class="price-box" id="maxPriceBox">RM <%=maxV%></div>
          </div>

          <button class="btn-filter" type="submit">Tapis</button>

          <a href="<%=request.getContextPath()%>/products<%= (sel!=null ? "?categoryId="+sel : "") %>"
             style="display:block;margin-top:10px;text-align:center;font-weight:900;color:#777;">
            Reset Harga
          </a>
        </form>
      </div>
    </aside>

    <!-- RIGHT: CONTENT -->
    <main>
      <!-- hero banner -->
      <section class="p-hero">
        <div class="p-hero-left">
          <h2 class="p-hero-title">Product List</h2>
          
        </div>
        
      </section>

      <!-- toolbar -->
      <section class="p-toolbar">
        <div class="p-count">
          <span class="dot"></span>

          <%
            List<Product> psCount = (List<Product>) request.getAttribute("products");
            int count = (psCount == null ? 0 : psCount.size());
          %>
          <span><%=count%> Produk</span>
        </div>

      
      </section>

      <!-- product grid -->
      <section class="p-grid">
        <%
          List<Product> ps = (List<Product>) request.getAttribute("products");
          if (ps != null && !ps.isEmpty()) {
            for (Product p : ps) {

              String img1 = (p.getImageUrl() == null ? "" : p.getImageUrl().trim());
              String img2 = (p.getImage2() == null ? "" : p.getImage2().trim());

              String mainSrc = request.getContextPath() + "/" + img1;
              boolean hasHover = (img2 != null && !img2.isEmpty() && !"null".equalsIgnoreCase(img2));
              String hoverSrc = hasHover ? (request.getContextPath() + "/" + img2) : "";
        %>

          <div class="p-card">
            <a class="p-img" href="<%=request.getContextPath()%>/product?id=<%=p.getId()%>">
              <span class="wish"><i class="fa-solid fa-heart"></i></span>

              <%-- optional tag: show only some item as popular (template) --%>
              

              <img class="product-img"
                   src="<%=mainSrc%>"
                   data-main="<%=mainSrc%>"
                   data-hover="<%= hasHover ? hoverSrc : "" %>"
                   alt="<%=p.getName()%>">
            </a>

            <div class="p-body">
              <div class="p-name"><%=p.getName()%></div>

              <div class="p-rating">
                <span class="stars">
                  <i class="fa-solid fa-star"></i>
                  <i class="fa-solid fa-star"></i>
                  <i class="fa-solid fa-star"></i>
                  <i class="fa-solid fa-star"></i>
                  <i class="fa-solid fa-star-half-stroke"></i>
                </span>
                <span>• 400</span>
              </div>

              <div class="p-cat"><%=p.getCategoryName()%></div>

              <div class="p-bottom">
                <div class="p-price">RM <%=p.getPrice()%></div>
                <a class="btn-buy" href="<%=request.getContextPath()%>/product?id=<%=p.getId()%>">Buy Now</a>
              </div>
            </div>
          </div>

        <%
            }
          } else {
        %>
          <div style="padding:12px;font-weight:900;color:#666;">No products found.</div>
        <%
          }
        %>
      </section>

    </main>
  </div>
</div>

<script src="<%=request.getContextPath()%>/js/footer.js"></script>
<jsp:include page="parts/footer.jsp" />

<!-- ✅ hover swap + price range backend sync -->
<script>
document.addEventListener("DOMContentLoaded", function () {
  // hover swap
  document.querySelectorAll('.product-img').forEach(img => {
    const main = (img.dataset.main || "").trim();
    const hover = (img.dataset.hover || "").trim();
    if (!hover || hover === "/" || hover.includes("/null")) return;
    img.addEventListener('mouseenter', () => { img.src = hover; });
    img.addEventListener('mouseleave', () => { img.src = main; });
  });

  // price range -> update max box + hidden input
  const range = document.getElementById("priceRange");
  const maxBox = document.getElementById("maxPriceBox");
  const maxInput = document.getElementById("maxPriceInput");
  if(range && maxBox && maxInput){
    range.addEventListener("input", () => {
      maxBox.textContent = "RM " + range.value;
      maxInput.value = range.value;
    });
  }
});
</script>

</body>
</html>
