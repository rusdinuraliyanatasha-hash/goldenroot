<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*, model.Product, model.User" %>
<!DOCTYPE html>
<html>
<head>
  <title>Product Detail</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/footer.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

  <style>
    .thumb-row{ display:flex; gap:10px; margin-top:10px; flex-wrap:wrap; }
    .thumb-img{
      width:64px; height:64px; object-fit:cover;
      border-radius:12px; border:2px solid transparent;
      cursor:pointer; background:#fff;
    }
    .thumb-active{ border-color: var(--orange); }

    .thumb-video{
      width:64px; height:64px;
      border-radius:12px; border:2px solid transparent;
      cursor:pointer;
      background:#111; color:#fff;
      display:flex; align-items:center; justify-content:center;
    }
    .thumb-video.thumb-active{ border-color: var(--orange); }

    /* ===== Static rating UI ===== */
    .rating-row{
      display:flex;
      align-items:center;
      gap:10px;
      flex-wrap:wrap;
      margin: 8px 0 16px;
    }
    .stars{
      display:inline-flex;
      gap:4px;
      font-size: 15px;
      color: #f5a623;
    }
    .rating-meta{
      color: rgba(0,0,0,.6);
      font-size: 13px;
      font-weight: 700;
    }
    .review-card{
      padding:12px;
      border:1px solid #eee;
      border-radius:14px;
      background:#fff;
    }
    .review-top{
      display:flex;
      justify-content:space-between;
      gap:10px;
      flex-wrap:wrap;
      align-items:center;
      margin-bottom:6px;
    }
    .review-name{ font-weight:900; }
    .review-date{ opacity:.7; font-size:12px; font-weight:700; }
    .review-text{ margin-top:6px; line-height:1.55; }
  </style>
</head>
<body>

<jsp:include page="parts/header.jsp"/>

<div class="container">
  <%
    Product p = (Product) request.getAttribute("product");
    User u = (User) session.getAttribute("user");

    String img1 = (p.getImageUrl() == null ? "" : p.getImageUrl());
    String img2 = (p.getImage2() == null ? "" : p.getImage2());
    String img3 = (p.getImage3() == null ? "" : p.getImage3());
    String vid  = (p.getVideoUrl() == null ? "" : p.getVideoUrl());

    // ===== STATIC RATING + REVIEWS (NO DB) =====
    double avg = 4.9;
    int cnt = 5; // tunjuk 5 reviews dummy

    // 5 dummy reviews (static for all products)
    class DummyReview {
      String name, text, date;
      int rating;
      DummyReview(String name, int rating, String text, String date){
        this.name=name; this.rating=rating; this.text=text; this.date=date;
      }
    }
    List<DummyReview> dummyReviews = new ArrayList<>();
    dummyReviews.add(new DummyReview("Aina", 5, "Packaging cantik dan cepat sampai. Produk wangi & sedap dipakai.", "2 days ago"));
    dummyReviews.add(new DummyReview("Tasha", 5, "Tekstur ringan, sesuai untuk kulit sensitif. Recommended!", "4 days ago"));
    dummyReviews.add(new DummyReview("Hafiz", 5, "Overall memang puas hati. Harga berbaloi dengan kualiti.", "1 week ago"));
    dummyReviews.add(new DummyReview("Farah", 4, "Good product, cuma saya harap ada size kecil untuk trial.", "2 weeks ago"));
    dummyReviews.add(new DummyReview("Nadia", 5, "Repeat purchase! Effect nampak cepat dan kulit rasa lembap.", "3 weeks ago"));
  %>

  <div class="card" style="padding:18px;">
    <div style="display:flex; gap:18px; align-items:flex-start; flex-wrap:wrap;">

      <!-- LEFT: MAIN + THUMB -->
      <div style="width:320px; max-width:100%;">

        <!-- MAIN IMAGE -->
        <img id="mainImg"
             src="<%=request.getContextPath()%>/<%=img1%>"
             style="width:100%; height:320px; object-fit:contain; background:#fff3e6; border-radius:16px; border:1px solid #f1e3d3;">

        <!-- VIDEO (hidden default, show bila click video thumb) -->
        <video id="mainVideo"
               style="display:none; width:100%; height:320px; background:#000; border-radius:16px; border:1px solid #f1e3d3;"
               controls></video>

        <!-- THUMBNAILS -->
        <div class="thumb-row">

          <!-- img1 -->
          <img class="thumb-img thumb-active"
               data-type="img"
               data-src="<%=request.getContextPath()%>/<%=img1%>"
               src="<%=request.getContextPath()%>/<%=img1%>"
               alt="thumb-1">

          <!-- img2 -->
          <% if (img2 != null && !img2.trim().isEmpty()) { %>
            <img class="thumb-img"
                 data-type="img"
                 data-src="<%=request.getContextPath()%>/<%=img2%>"
                 src="<%=request.getContextPath()%>/<%=img2%>"
                 alt="thumb-2">
          <% } %>

          <!-- img3 -->
          <% if (img3 != null && !img3.trim().isEmpty()) { %>
            <img class="thumb-img"
                 data-type="img"
                 data-src="<%=request.getContextPath()%>/<%=img3%>"
                 src="<%=request.getContextPath()%>/<%=img3%>"
                 alt="thumb-3">
          <% } %>

          <!-- video thumb -->
          <% if (vid != null && !vid.trim().isEmpty()) { %>
            <div class="thumb-video"
                 data-type="video"
                 data-src="<%=vid%>"
                 title="Play video">
              <i class="fa-solid fa-play"></i>
            </div>
          <% } %>

        </div>
      </div>

      <!-- RIGHT: DETAILS -->
      <div style="flex:1; min-width:260px;">
        <h2 style="margin:0 0 8px 0;"><%=p.getName()%></h2>
        <div class="muted" style="margin-bottom:10px;"><%=p.getCategoryName()%></div>

        <div style="font-weight:900; font-size:22px; color:var(--orange); margin-bottom:6px;">
          RM <%=p.getPrice()%>
        </div>

        <!-- ===== STATIC STAR RATING (NO DB) ===== -->
        <div class="rating-row">
          <div class="stars" aria-label="Rating 4.9 out of 5">
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
            <i class="fa-solid fa-star"></i>
          </div>
          <div class="rating-meta">
            <b><%=String.format("%.1f", avg)%></b> / 5.0 (<%=cnt%> reviews)
          </div>
        </div>

        <form method="post" action="<%=request.getContextPath()%>/cart/add" style="margin:0;">
          <input type="hidden" name="productId" value="<%=p.getId()%>">
          <button class="btn btn-primary" type="submit">Add to Cart</button>
        </form>

        <%
          try {
            String desc = (String) p.getClass().getMethod("getDescription").invoke(p);
            if (desc != null && !desc.trim().isEmpty()) {
        %>
          <div style="margin-top:16px;">
            <h3 style="margin:0 0 6px 0;">Details</h3>
            <div class="muted"><%=desc%></div>
          </div>
        <%
            }
          } catch (Exception ignore) {}
        %>
      </div>
    </div>
  </div>

  <div style="height:14px;"></div>

  <!-- ===== STATIC REVIEWS (NO DB) ===== -->
  <div class="card" style="padding:18px;">
    <h3 style="margin:0 0 10px 0;">Customer Reviews</h3>

    <!-- NOTE: Review submission disabled (no DB) -->
    <div class="muted" style="margin-bottom:14px;">
      
    </div>

    <div style="display:flex; flex-direction:column; gap:12px;">
      <% for (DummyReview r : dummyReviews) { %>
        <div class="review-card">
          <div class="review-top">
            <div class="review-name"><%=r.name%></div>
            <div class="review-date"><%=r.date%></div>
          </div>

          <div class="stars" style="font-size:13px;">
            <% for(int i=0;i<r.rating;i++){ %>
              <i class="fa-solid fa-star"></i>
            <% } %>
            <% for(int i=r.rating;i<5;i++){ %>
              <i class="fa-regular fa-star"></i>
            <% } %>
          </div>

          <div class="review-text"><%=r.text%></div>
        </div>
      <% } %>
    </div>

  </div>

</div>

<script src="<%=request.getContextPath()%>/js/footer.js"></script>
<jsp:include page="parts/footer.jsp" />

<script>
const mainImg = document.getElementById("mainImg");
const mainVideo = document.getElementById("mainVideo");

function setActiveThumb(el){
  document.querySelectorAll(".thumb-img").forEach(x => x.classList.remove("thumb-active"));
  document.querySelectorAll(".thumb-video").forEach(x => x.classList.remove("thumb-active"));
  el.classList.add("thumb-active");
}

document.querySelectorAll(".thumb-img, .thumb-video").forEach(t => {
  t.addEventListener("click", () => {
    const type = t.dataset.type;
    const src  = t.dataset.src;

    if (!src) return;

    if (type === "img") {
      mainVideo.pause();
      mainVideo.style.display = "none";
      mainImg.style.display = "block";
      mainImg.src = src;
    } else if (type === "video") {
      mainImg.style.display = "none";
      mainVideo.style.display = "block";
      mainVideo.src = src;
      mainVideo.play().catch(()=>{});
    }

    setActiveThumb(t);
  });
});
</script>

</body>
</html>
