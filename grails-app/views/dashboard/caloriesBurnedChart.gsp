<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
	<script type="text/javascript">
		
		function drawChart() {
	        // Create the data table.
	        var data = new google.visualization.DataTable();
	        data.addColumn('string', 'Topping');
	        data.addColumn('number', 'Slices');
	        data.addRows([
	          ['Mushrooms', 3],
	          ['Onions', 1],
	          ['Olives', 1],
	          ['Zucchini', 1],
	          ['Pepperoni', 2]
	        ]);

	        // Set chart options
	        var options = {'title':'How Much Pizza I Ate Last Night',
	                       'width':400,
	                       'height':300};

	        // Instantiate and draw our chart, passing in some options.
	        var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
	        chart.draw(data, options);
	      }
	</script>
</head>
<body>
	<g:each in="${data}">
		${it.caloriesBurned}
	</g:each>
	<div id="chart_div"></div>
</body>
</html>