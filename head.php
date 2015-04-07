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
  <link rel="stylesheet" href="css/foundation.css" />
  <script src="js/vendor/modernizr.js"></script>
</head>
	<?php

		$host = 'localhost';
		$port = '5432';
		$user = 'nicolasdubus';
		$password = 'Ilikepie69!';
		$dbname = 'nicolasdubus';
		$options = "host={$host} port={$port} user={$user} password={$password} dbname={$dbname}";
		$conn = pg_connect($options);

		if(!$conn){
			echo "Connection Failed \n";
			exit;
		}
	?>

	