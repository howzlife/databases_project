<!doctype html>
<!--[if IE 9]><html class="lt-ie10" lang="en" > <![endif]-->
<html class="no-js" lang="en" data-useragent="Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.2; Trident/6.0)">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>uOttawa Urban Spoon</title>
    <meta name="description" content="Documentation and reference library for ZURB Foundation. JavaScript, CSS, components, grid and more."/>
    <meta name="author" content="ZURB, inc. ZURB network also includes zurb.com"/>
    <meta name="copyright" content="ZURB, inc. Copyright (c) 2015"/>
  <link rel="stylesheet" href="../css/foundation.css" />
  <script src="../js/vendor/modernizr.js"></script>
</head>
<body>
 
<div class="row">
  <div class="large-12 columns">
    <div class="nav-bar right">
      <ul class="button-group">
        <li><a href="#" class="button success small">Join</a></li>
        <li><a href="#" class="button small">Sign In</a></li>
      </ul>
      </div>
      <h1>uOttawa <small>Urban Spoon</small></h1>
    <hr/>
  </div>
</div>
 
 
<div class="row">
 
<div class="large-9 columns" role="content">
    <!-- Rater Loop Start -->
    <?php foreach ($raters as $rater): ?>
      <div class="row">
        <div class="large-3 columns">
            <img src="http://placekitten.com/g/400/200" />
             <br />
            <a href="mailto:<?php echo $rater['email'] ?>?Subject=Hello%20again%20<?php echo $rater['name'] ?>" target="_top">Send Mail</a> <br />
        </div>
        <div class="large-9 columns">
          <h1><?php echo $rater['name'] ?></h1> <br />
          Joined on <?php echo $rater['join_date'] ?> <br />
          Reviewed the following restaurants:
            <?php
                $reviews = null; 
                $reviews = get_all_restaurants_reviewed($rater['userid']); 
                ?>
            <ul>
                <!-- Reviewed Restaurants Start -->
            <?php foreach ($reviews as $review): ?>
                <li> 
                    <?php $restaurantid = $review['restaurantid'] ?>
                    <a href="review.php?restaurantid=<?php echo $review['restaurantid'] ?>&userid=<?php echo $rater['userid'] ?>"><?php echo restaurant_name_based_on_id($restaurantid) ?></a>
                </li>
            <?php endforeach ?>
                <!-- Reviewed Restaurants End -->
            </ul>
        </div>
      </div>
      <hr />
    <?php endforeach ?>
    <!-- Rater Loop End -->
</div>

<aside class="large-3 columns">
  <h3><small>What's nearby</small></h3>
  <div class="row">
    <div class="large-3 columns">
        <img src="http://placehold.it/100x93" />
    </div>
    <div class="large-9 columns">
        <h3><small><a href="#">Restaurant Title</a></small></h3>
       <p>123 Clarence St.</p>
      </div>
  </div>
</aside>
 
</div>
 
 
<footer class="row">
  <div class="large-12 columns">
    <hr/>
    <div class="row">
      <div class="large-6 columns">
      <p>&copy; uOttawa Urban Spoon</p>
      </div>
      <div class="large-6 columns">
      <ul class="inline-list right">
      <li><a href="_template.html">Index Template</a></li>
      <li><a href="_template_rest_template.html">Restaurant Template</a></li>
      <li><a href="raters.php">Raters</a></li>
      <li><a href="#">Link 4</a></li>
      </ul>
      </div>
    </div>
  </div>
</footer>
<script>
  document.write('<script src=js/vendor/' +
  ('__proto__' in {} ? 'zepto' : 'jquery') +
  '.js><\/script>')
  </script>
<script src="../../assets/js/jquery.js"></script>
<script src="js/foundation.min.js"></script>
<script>
    $(document).foundation();
  </script>
<script src="../assets/js/templates/jquery.js"></script>
<script src="../assets/js/templates/foundation.js"></script>
<script>
      $(document).foundation();

      var doc = document.documentElement;
      doc.setAttribute('data-useragent', navigator.userAgent);
    </script>
</body>
</html>