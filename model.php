<?php

	function open_database_connection(){
		$options = "host='localhost' port='5432' user='student' password='winter2015' dbname='csi2132a'";
		$conn = pg_connect($options);

		if(!$conn){
			echo "Connection Failed \n";
			exit;
		}
		return $conn;
	}

	function close_database_connection($conn){
		pg_close($conn);
	}

	function get_all_raters(){
		$conn = open_database_connection();

		$result = pg_query($conn, "SELECT * FROM rater");

		$raters = array();

		while($row = pg_fetch_assoc($result)){
			$raters[] = $row;
		}

		close_database_connection($conn);

		return $raters;
	}

	function get_all_restaurants_reviewed($raterid){
		$conn = open_database_connection();

		$userid = intval($raterid);
		$query = "SELECT restaurantid, overall FROM rating WHERE userid = " .$userid;
		$result = pg_query($conn, $query);

		$restaurants_reviewed = array();

		while($row = pg_fetch_assoc($result)){
			$restaurants_reviewed[] = $row;
		}

		close_database_connection($conn);

		return $restaurants_reviewed;
	}

	function restaurant_name_based_on_id($restaurantid){
		$conn = open_database_connection();

		$restaurantid = intval($restaurantid);
		$restaurantid = $restaurantid - 1;
		$query = "SELECT * FROM restaurant";

		$result = pg_query($conn, $query);

		$restaurants = array();

		while($row = pg_fetch_assoc($result)){
			$restaurants[] = $row;
		}

		close_database_connection($conn);

		return $restaurants[$restaurantid]['name'];

	}
?>