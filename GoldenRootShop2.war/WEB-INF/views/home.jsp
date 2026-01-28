<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%@ page import="model.Product" %>

<!DOCTYPE html>
<html>
<head>
  <title>Home - Golden Root</title>

  <!-- Icons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">

  <!-- ✅ CSS ONLY IN home.jsp -->
  <style>
    :root{
      --orange:#f57c00;
      --orange2:#ff8a00;
      --cream:#fff7ee;
      --bg:#fff4ea;
      --text:#111;
      --muted:#6f6f6f;
      --border:#f0e3d8;
      --shadow:0 12px 30px rgba(0,0,0,.10);
      --shadow2:0 18px 50px rgba(0,0,0,.14);
      --radius:18px;
      --green:#2e7d32;
      --green2:#43a047;
    }

    *{box-sizing:border-box}
    body{margin:0;font-family:Arial,Helvetica,sans-serif;background:var(--bg);color:var(--text)}
    a{text-decoration:none;color:inherit}
    .container{width:92%;max-width:1200px;margin:16px auto}

    /* ===== HERO PROMO (macam contoh) ===== */
    .home-hero{
      margin-top: 16px;
      background: linear-gradient(135deg, #ffe2c6, #fff);
      border: 1px solid var(--border);
      border-radius: 22px;
      box-shadow: var(--shadow);
      overflow: hidden;
      position: relative;
    }

    .home-hero-inner{
      display:grid;
      grid-template-columns: 1.1fr .9fr;
      gap: 18px;
      padding: 22px;
      align-items: center;
      min-height: 240px;
    }

    .hero-title{
      margin:0;
      font-size:44px;
      font-weight:900;
      line-height:1.05;
      letter-spacing:.2px;
    }
    .hero-title .accent{color:var(--orange)}
    .hero-sub{
      margin:12px 0 0;
      font-weight:800;
      color:#2b2b2b;
      opacity:.85;
    }

    .discount-tag{
      display:inline-flex;align-items:center;gap:10px;
      background: linear-gradient(135deg, var(--green2), var(--green));
      color:#fff;
      padding: 10px 14px;
      border-radius: 14px;
      font-weight:900;
      box-shadow: 0 16px 34px rgba(67,160,71,.28);
      margin-top: 14px;
      width: max-content;
    }
    .discount-tag b{
      font-size: 28px;
      line-height: 1;
    }

    .hero-actions{
      display:flex;
      gap:12px;
      flex-wrap:wrap;
      margin-top: 16px;
    }

    .btn{
      border:none;
      cursor:pointer;
      border-radius:999px;
      padding:12px 18px;
      font-weight:900;
      display:inline-flex;
      align-items:center;
      gap:10px;
      box-shadow:0 14px 28px rgba(0,0,0,.12);
    }
    .btn-primary{background:var(--orange);color:#fff;}
    .btn-primary:hover{background:#e56f00;}
    .btn-secondary{
      background:#fff;
      color:#1a1a1a;
      border:1px solid #f0e0d1;
      box-shadow:0 12px 24px rgba(0,0,0,.06);
    }
    .btn-secondary:hover{border-color:#ead2bf;}

    .hero-imgbox{
      width:100%;
      max-width:420px;
      aspect-ratio: 16 / 10;
      border-radius: 18px;
      background:#fff;
      border:1px solid #f0e0d1;
      box-shadow: var(--shadow2);
      overflow:hidden;
      margin-left:auto;
    }
    .hero-imgbox img{
      width:100%;
      height:100%;
      object-fit:cover;
      display:block;
    }

    /* ===== SECTION WRAPPER (macam kad) ===== */
    .panel{
      margin-top: 18px;
      background:#fff;
      border:1px solid var(--border);
      border-radius: 18px;
      box-shadow: 0 12px 26px rgba(0,0,0,.06);
      padding: 14px 14px 10px;
    }

    .panel-head{
      display:flex;
      justify-content:space-between;
      align-items:flex-end;
      gap:12px;
      padding: 6px 6px 0;
    }

    .panel-title{
      margin:0;
      font-size:18px;
      font-weight:900;
      display:flex;
      align-items:center;
      gap:10px;
    }
    .panel-title i{color:var(--orange)}
    .panel-sub{
      margin:6px 0 0;
      color:var(--muted);
      font-weight:700;
    }
    .more-link{
      font-weight:900;
      color:var(--orange);
      display:inline-flex;
      align-items:center;
      gap:8px;
      padding:8px 10px;
      border-radius:10px;
    }
    .more-link:hover{background:#fff3e6}

    /* ===== CATEGORY TILES (template) ===== */
    .cats{
      padding: 12px 6px 14px;
      display:grid;
      grid-template-columns: repeat(6, 1fr);
      gap: 14px;
    }
    .cat{
      background: linear-gradient(180deg, #fff8f1, #fff);
      border: 1px solid #f2e3d6;
      border-radius: 16px;
      box-shadow: 0 10px 22px rgba(0,0,0,.06);
      padding: 12px 10px;
      text-align:center;
      transition: transform .15s ease;
      min-height: 92px;
      display:flex;
      flex-direction:column;
      justify-content:center;
      gap: 8px;
    }
    .cat:hover{transform: translateY(-3px)}
    .cat i{font-size:22px;color:var(--orange)}
    .cat .name{font-weight:900}
    .cat .count{font-weight:900;color:#ff6f00;opacity:.9;font-size:12px}

    /* ===== BEST SELLER GRID ===== */
    .grid{
      padding: 12px 6px 14px;
      display:grid;
      grid-template-columns: repeat(4, 1fr);
      gap: 16px;
    }
    .card{
      background:#fff;
      border:1px solid #f2e3d6;
      border-radius: 18px;
      overflow:hidden;
      box-shadow: 0 12px 26px rgba(0,0,0,.08);
      display:flex;
      flex-direction:column;
      height:100%;
      transition: transform .16s ease, box-shadow .16s ease;
    }
    .card:hover{
      transform: translateY(-5px);
      box-shadow: 0 18px 40px rgba(0,0,0,.12);
    }
    .card-img{
      height: 190px;
      background: linear-gradient(180deg, #fff7ee, #fff);
      display:flex;
      align-items:center;
      justify-content:center;
      padding: 12px;
      position: relative;
    }
    .card-img img{
      width:100%;
      height:100%;
      object-fit: contain;
      display:block;
    }

    .pill{
      position:absolute;
      top: 12px; left: 12px;
      background: linear-gradient(135deg, var(--orange2), var(--orange));
      color:#fff;
      font-weight:900;
      font-size:12px;
      padding:8px 10px;
      border-radius:999px;
      box-shadow: 0 12px 22px rgba(245,124,0,.22);
      z-index: 2;
    }

    .card-body{
      padding: 12px 12px 14px;
      display:flex;
      flex-direction:column;
      flex: 1;
      gap: 8px;
    }

    .card-name{
      font-weight:900;
      line-height:1.25;

      /* ✅ title clamp 5 line */
      display: -webkit-box !important;
      -webkit-line-clamp: 5 !important;
      -webkit-box-orient: vertical !important;
      overflow: hidden !important;
      white-space: normal !important;
    }

    .card-cat{
      font-size:13px;
      color: var(--muted);
      font-weight:800;
    }

    .card-row{
      margin-top:auto;
      display:flex;
      justify-content:space-between;
      align-items:center;
      gap: 10px;
      padding-top: 10px;
    }

    .price{
      font-weight:900;
      color:#ff6f00;
      font-size:14px;
    }

    .btn-buy{
      border:none;
      cursor:pointer;
      border-radius: 12px;
      padding: 10px 14px;
      font-weight:900;
      background: linear-gradient(135deg, var(--green2), var(--green));
      color:#fff;
      box-shadow: 0 14px 28px rgba(46,125,50,.20);
      white-space: nowrap;
    }
    .btn-buy:hover{filter: brightness(.95);}

    /* ===== responsive ===== */
    @media (max-width: 1050px){
      .home-hero-inner{grid-template-columns:1fr}
      .hero-title{font-size:36px}
      .hero-imgbox{max-width:100%;margin-left:0}
      .cats{grid-template-columns:repeat(3,1fr)}
      .grid{grid-template-columns:repeat(2,1fr)}
    }
    @media (max-width: 560px){
      .hero-title{font-size:30px}
      .cats{grid-template-columns:repeat(2,1fr)}
      .grid{grid-template-columns:1fr}
    }
  </style>
</head>

<body>

  <jsp:include page="parts/header.jsp"/>

  <div class="container">

    <!-- HERO -->
    <section class="home-hero">
      <div class="home-hero-inner">
        <div>
          <h1 class="hero-title">
            Natural & <span class="accent">Healthy!</span><br>
            Live Better with Ginger.
          </h1>
          <p class="hero-sub">Clean & honest ginger-based products made for modern lifestyle.</p>

          

          <div class="hero-actions">
            <a class="btn btn-primary" href="<%=request.getContextPath()%>/products">
              <i class="fa-solid fa-bag-shopping"></i> Shop Now
            </a>
            
          </div>
        </div>

        <div class="hero-imgbox">
          <img src="<%=request.getContextPath()%>/images/Product.jpeg" alt="Hero Template">
        </div>
      </div>
    </section>

    

    <!-- BEST SELLER (highlights) -->
    <section class="panel">
      <div class="panel-head">
        <div>
          <h3 class="panel-title"><i class="fa-solid fa-fire"></i> Special Product</h3>
          <p class="panel-sub">Click to Buy Now</p>
        </div>

        <a class="more-link" href="<%=request.getContextPath()%>/products">
          View All <i class="fa-solid fa-arrow-right"></i>
        </a>
      </div>

      <%
        List<Product> highlights = (List<Product>) request.getAttribute("highlights");
      %>

      <% if (highlights == null || highlights.isEmpty()) { %>
        <div style="padding:14px 6px 16px;color:#555;font-weight:800;">
          No highlighted products yet. (Admin can set Highlight in Manage Products.)
        </div>
      <% } else { %>

        <div class="grid">
          <% for (Product p : highlights) {

               String img1 = (p.getImageUrl() == null ? "" : p.getImageUrl().trim());
               String img2 = (p.getImage2() == null ? "" : p.getImage2().trim());

               String mainSrc = request.getContextPath() + "/" + img1;

               boolean hasHover = (img2 != null && !img2.isEmpty() && !"null".equalsIgnoreCase(img2));
               String hoverSrc = hasHover ? (request.getContextPath() + "/" + img2) : "";
          %>

            <div class="card">
              <a class="card-img" href="<%=request.getContextPath()%>/product?id=<%=p.getId()%>">
                <div class="pill">Popular</div>

                <!-- ✅ HOVER SWAP BACK -->
                <img class="product-img"
                     src="<%=mainSrc%>"
                     data-main="<%=mainSrc%>"
                     data-hover="<%=hoverSrc%>"
                     alt="<%=p.getName()%>">
              </a>

              <div class="card-body">
                <div class="card-name"><%=p.getName()%></div>
                <div class="card-cat"><%=p.getCategoryName()%></div>

                <div class="card-row">
                  <div class="price">RM <%=p.getPrice()%></div>

                  <a class="btn-buy" href="<%=request.getContextPath()%>/product?id=<%=p.getId()%>">
                    Buy Now
                  </a>
                </div>
              </div>
            </div>

          <% } %>
        </div>

      <% } %>
    </section>

  </div>

  <jsp:include page="parts/footer.jsp" />
  <script src="<%=request.getContextPath()%>/js/footer.js"></script>

  <!-- ✅ FIX HOVER SCRIPT (same as your products page) -->
  <script>
  document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll('.product-img').forEach(img => {
      const main = (img.dataset.main || "").trim();
      const hover = (img.dataset.hover || "").trim();

      // if no hover image, skip
      if (!hover || hover.includes("/null") || hover.endsWith("/")) return;

      img.addEventListener('mouseenter', () => { img.src = hover; });
      img.addEventListener('mouseleave', () => { img.src = main; });
    });
  });
  </script>

</body>
</html>
