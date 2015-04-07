<?php require 'head.php'; ?>

<body>
 
<?php require 'header.php'; 

    $result = pg_query($conn, "SELECT * FROM restaurant;");

?>
 
 
<div class="row">

<aside class="large-3 columns">
  <h3><small>Cuisines</small></h3>
  <ul class="side-nav">
    <li><a href="#">Sports Bar (23)</a></li>
    <li><a href="#">Fast Food (23)</a></li>
    <li><a href="#">Italian (23)</a></li>
    <li><a href="#">Family Style (23)</a></li>
  </ul>
  <div class="panel">
  <h5>Featured</h5>
    <p>Pork drumstick turkey fugiat. Tri-tip elit turducken pork chop in. Swine short ribs meatball irure bacon nulla pork belly cupidatat meatloaf cow.</p>
    <a href="#">Read More &rarr;</a>
  </div>
</aside>
 
 <?php  while ($row = pg_fetch_row($result)) { ?>
    <div class='large-5 columns' role='content'>
  <?php echo "<h3>$row[1]</h3> "; ?> 
  <?php echo "<h5>Ottawa, Ontario, Canada </h5>"; ?>
  <?php echo "Restaurant Style: $row[2] "; ?> <br>
  <?php echo "Restaurant Website: <a href='http://$row[3]'>$row[3]</a> "; ?> <br>
  <?php $locationResults = pg_query($conn,  "SELECT * FROM location l WHERE l.RestaurantID = $row[0]"); ?>
  <?php echo "Locations: " ?> <br>
        <?php while ($row2 = pg_fetch_row($locationResults)) { ?>
          <?php echo "Street Address: $row2[4]"; ?> <br>
          <?php echo "Phone Number: $row2[3]"; ?>
        <?php } ?>
    </div>

    <div class="row">
      <div class="large-3 columns">
        <img src="http://placekitten.com/g/500/300" />
        <br><br>
          <div class="ratings-container">
          <?php $avg = pg_query($conn, "SELECT ROUND(AVG(Price), 1), ROUND(AVG(Food), 1), ROUND(AVG(Mood), 1), ROUND(AVG(Staff), 1), ROUND(AVG(Overall), 1) FROM Rating R WHERE R.RestaurantID = $row[0]"); 
          
          echo "<table>
            <tr>
              <td>$</td>
              <td>Food</td>
              <td>Mood</td>
              <td>Staff</td>
              <td>Avg</td>
            </tr>";
      
          while ($row3 = pg_fetch_row($avg)) {
              echo "<tr><td>$row3[0]</td><td>$row3[1]</td><td>$row3[2]</td><td>$row3[3]</td><td>$row3[4]</td></tr>";
              echo "\n";
          }

          echo "</table>"; ?>
        </div>
      </div>
    </div>
     </hr>
    <?php } ?>


<div class="large-9 columns" role="content">
  <article>
    <div class="row">
      <div class="large-3 columns">
        <img src="http://placekitten.com/g/400/200" />
      </div>
      <div class="large-9 columns">
        <h3><a href="#">Restaurant Title</a></h3>
        <h6>CRITIC FROM OTTAWA • <a href="">123 Reviews</a></h6>
            <p>Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit. Aute in reprehenderit, dolore aliqua non est magna in labore pig pork biltong. Eiusmod swine spare ribs reprehenderit culpa.</p>
            <p>Boudin aliqua adipisicing rump corned beef. Nulla corned beef sunt ball tip, qui bresaola enim jowl. Capicola short ribs minim salami nulla nostrud pastrami... <a href="#">Full Review</a></p>
            <p>Posted on 01/01/2015</p> 
      </div>
    </div>
  </article>
  <hr/>

  <article>
    <div class="row">
      <div class="large-3 columns">
        <img src="http://placekitten.com/g/400/200" />
      </div>
      <div class="large-9 columns">
        <h3><a href="#">Restaurant Title</a></h3>
        <h6>CRITIC FROM OTTAWA • <a href="">123 Reviews</a></h6>
            <p>Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit. Aute in reprehenderit, dolore aliqua non est magna in labore pig pork biltong. Eiusmod swine spare ribs reprehenderit culpa.</p>
            <p>Boudin aliqua adipisicing rump corned beef. Nulla corned beef sunt ball tip, qui bresaola enim jowl. Capicola short ribs minim salami nulla nostrud pastrami... <a href="#">Full Review</a></p>
            <p>Posted on 01/01/2015</p> 
      </div>
    </div>
  </article>
  <hr/>
    <article>
    <div class="row">
      <div class="large-3 columns">
        <img src="http://placekitten.com/g/400/200" />
      </div>
      <div class="large-9 columns">
        <h3><a href="#">Restaurant Title</a></h3>
        <h6>CRITIC FROM OTTAWA • <a href="">123 Reviews</a></h6>
            <p>Bacon ipsum dolor sit amet nulla ham qui sint exercitation eiusmod commodo, chuck duis velit. Aute in reprehenderit, dolore aliqua non est magna in labore pig pork biltong. Eiusmod swine spare ribs reprehenderit culpa.</p>
            <p>Boudin aliqua adipisicing rump corned beef. Nulla corned beef sunt ball tip, qui bresaola enim jowl. Capicola short ribs minim salami nulla nostrud pastrami... <a href="#">Full Review</a></p>
            <p>Posted on 01/01/2015</p> 
      </div>
    </div>
  </article>
</div>
 
</div>
 
 
<footer class="row">
  <div class="large-12 columns">
    <hr/>
    <div class="row">
      <div class="large-6 columns">
      <p>&copy; Copyright no one at all. Go to town.</p>
      </div>
      <div class="large-6 columns">
      <ul class="inline-list right">
      <li><a href="_template.html">Index</a></li>
      <li><a href="#">Link 2</a></li>
      <li><a href="#">Link 3</a></li>
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
<?php 		pg_close($conn); ?>
</html>