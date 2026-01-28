<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>Our Story - Golden Root</title>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/style.css">
  <link rel="stylesheet" href="css/footer.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
</head>
<body>

<jsp:include page="parts/header.jsp"/>


<div class="container">
  <h2 class="section-title">Our History</h2>
  <p class="muted">A journey of clean, premium and honest products.</p>

  <div class="story-grid">

    <article class="story-card">
      <div class="story-img">
        <img src="<%=request.getContextPath()%>/images/Product.jpeg" alt="Memorable">
      </div>
      <div class="story-body">
        <h3>Memorable beginning</h3>
        <p class="muted">
          Golden Root began from a passion for natural ingredients and safe daily self-care routines.
        </p>
      </div>
      <div class="story-year">1984</div>
    </article>

    <article class="story-card">
      <div class="story-img">
        <img src="<%=request.getContextPath()%>/images/Founder.jpeg" alt="Founding">
      </div>
      <div class="story-body">
        <h3>Founding the brand</h3>
        <p class="muted">
		We began developing our formulas with a strong focus on quality and comfort for everyone.        </p>
      </div>
      <div class="story-year orange">1990</div>
    </article>

    <article class="story-card">
      <div class="story-img">
        <img src="<%=request.getContextPath()%>/images/Halia.jpeg" alt="Clean">
      </div>
      <div class="story-body">
        <h3>Clean & premium</h3>
        <p class="muted">
         Our products are designed with carefully selected ingredients, kept simple, and made to suit a modern lifestyle.
        </p>
      </div>
      <div class="story-year">2010</div>
    </article>

    <article class="story-card">
      <div class="story-img">
        <img src="<%=request.getContextPath()%>/images/Team.jpeg" alt="Today">
      </div>
      <div class="story-body">
        <h3>Today & beyond</h3>
        <p class="muted">
          We continue to improve, listen to customer feedback, and stay consistent with our “clean & honest” mission.
        </p>
      </div>
      <div class="story-year">2026</div>
    </article>

  </div>
</div>

<script src="<%=request.getContextPath()%>/js/footer.js"></script>

<jsp:include page="parts/footer.jsp" />

</body>
</html>
