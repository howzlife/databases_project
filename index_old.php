<html>
 <head>
  <title>Users</title>
 </head>
 <body>
	<?php
		$options = "host='localhost' port='5432' user='student' password='winter2015' dbname='csi2132a'";
		$conn = pg_connect($options);

		if(!$conn){
			echo "Connection Failed \n";
			exit;
		}

		$result = pg_query($conn, "SELECT * FROM rater;");
		
		if (!$result) {
			echo "Cannot execute the query.\n";
			exit;
		}else {
			echo "<table>
					<tr>
						<td></td>
						<td></td>
						<td></td>
					</tr>";
		}
		
		while ($row = pg_fetch_row($result)) {
	  		echo "<tr><td> $row[1]</td><td>$row[2]</td><td>$row[3]</td></tr>";
	  		echo "\n";
		}

		echo "</table>";

		pg_close($conn);
	?>
 </body>
</html>