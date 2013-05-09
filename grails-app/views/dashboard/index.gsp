<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
		<meta name="layout" content="main"/>
		<title>My Dashboard</title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'dashboard.css')}" type="text/css">
		<script type="text/javascript" src="https://www.google.com/jsapi" passthrough="true"></script>
		<r:require module="full-calendar"/>
		<style type="text/css">
			#navList li{
				background-color:#C9C9C9;
			}
			#navList li:hover{
				background-color:white !important;
			}
			#navList li:hover a{
				color:black !important;
			}
			#navList li a{
				color:white;
			}
			.selected {
				background-color:white !important;
				border-top:2px solid #C0C0C0 !important;
				border-left:2px solid #C0C0C0 !important;
				border-right:2px solid #C0C0C0 !important;
				border-bottom:0px !important;
				-moz-box-shadow: 0 0 0.3em -0.3em #000000 !important;
				-webkit-box-shadow: 0 0 0.3em -0.3em #000000 !important;
				        box-shadow: 0 0 0.3em -0.3em #000000 !important;
			}
			.selected a{
				color:black !important;
			}
			#calendar table tr:hover{
				background-color:white;
			}
		</style>
		<r:script passthrough="true">
		
			google.load('visualization', '1.0', {'packages':['corechart']});
			google.setOnLoadCallback(drawCharts);
		
			$(document).ready(function(){

				var date = new Date();
				var d = date.getDate();
				var m = date.getMonth();
				var y = date.getFullYear();
				
				$('#calendar').fullCalendar({
					header: {
						left: 'prev,next today',
						center: 'title',
						right: 'month,agendaWeek,agendaDay'
					},
					editable: true,
					height: "450",
					events: [
						<g:each in="${dailyActivityInstanceList}">
							{
								title: '${it.title}',
								start: new Date(${it.startYear},${it.startMonth},${it.startDay}),
								end: new Date(${it.endYear},${it.endMonth},${it.endDay})
							},
						</g:each>
					]
				});
			});
		
			function switchTabs(link, tabName){
				$('#tabContent div[class=contentTab]').hide()
				$('#' + tabName).show()
				$('li').removeClass('selected');			
				$('#' + tabName + '-selector').addClass('selected');
			}
			
			function drawCharts(){
				drawCaloriesBurnedChart(0);
				drawHoursSleptChart(0);
				drawAggCaloriesBurnedChart(0);
				drawAggHoursSleptChart(0);
			}
			
			function getCalorieData(){
			
				var calorieData = new google.visualization.DataTable();
				calorieData.addColumn('date', 'Date');
				calorieData.addColumn('number', 'Calories');
				calorieData.addRows([
					<g:each in="${data}">
		        		[new Date(${it.getDayYear()}, ${it.getDayMonth()}, ${it.getDayDay()}), ${it.caloriesBurned}],
		        	</g:each>
				]);
				
				return calorieData;
			}
			
			function getCalorieDataAJAX(numDays, options){
			
				var url = '${createLink(controller:"Dashboard", action:"getDataAJAX")}?days=' + numDays;

				var chart = new google.visualization.LineChart(document.getElementById('calories_burned_chart_div'));
				
				var calorieData = new google.visualization.DataTable();
				calorieData.addColumn('date', 'Date');
				calorieData.addColumn('number', 'Calories');
			
				$.getJSON(url, function(data) {
				        $.each(data, function(index) {
				        	var year = data[index].year;
				        	var month = data[index].month;
				        	var day = data[index].day;
							var caloriesBurned = data[index].caloriesBurned;
							var fullDate = new Date(year,month,day);
							
							calorieData.addRow([fullDate, caloriesBurned]);
				        });
				        
				        chart.draw(calorieData, options);
				    });
			}
			
			function drawCaloriesBurnedChart(numDays) {
			
		        // Set chart options
		        var options = {'title':'',
		                       'width':500,
		                       'height':350,
		                       'thickness':8};
		        
		        var chart = new google.visualization.LineChart(document.getElementById('calories_burned_chart_div'));
		        if(numDays == 0){
		        	chart.draw(getCalorieData(), options);
		        }
		        else{
		        	getCalorieDataAJAX(numDays, options);
		        }
		    }
		    
		    function getAggCalorieData(){
		    	var calorieData = new google.visualization.DataTable();
		    	calorieData.addColumn('date', 'Date');
		    	calorieData.addColumn('number', 'Calories');
		    	calorieData.addColumn('number', 'Team Average');
		    	calorieData.addColumn('number', 'Team Goal');
		    	calorieData.addRows([
		    		<g:each in="${data}">
		    			[new Date(${it.getDayYear()}, ${it.getDayMonth()}, ${it.getDayDay()}), ${it.caloriesBurned}, ${it.getTeamAverageCalories()}, ${it.getTeamCaloriesGoal()}],
		    		</g:each>
		    	]);
		    	
		    	return calorieData;
		    }
		    
		    function getAggCalorieDataAJAX(numDays, options){
		    	var url = '${createLink(controller:"Dashboard", action:"getDataAJAX")}?days=' + numDays;

				var chart = new google.visualization.LineChart(document.getElementById('agg_calories_burned_chart_div'));
				
				var calorieData = new google.visualization.DataTable();
				calorieData.addColumn('date', 'Date');
				calorieData.addColumn('number', 'Calories');
				calorieData.addColumn('number', 'Team Average');
				calorieData.addColumn('number', 'Team Goal');
			
				$.getJSON(url, function(data) {
				        $.each(data, function(index) {
				        	var year = data[index].year;
				        	var month = data[index].month;
				        	var day = data[index].day;
							var caloriesBurned = data[index].caloriesBurned;
							var teamAverage = data[index].teamAverageCalories;
							var goal = data[index].calorieGoal;
							var fullDate = new Date(year,month,day);
							
							calorieData.addRow([fullDate, caloriesBurned, teamAverage, goal]);
				        });
				        
				        chart.draw(calorieData, options);
				    });
		    }
		    
		    function drawAggCaloriesBurnedChart(numDays){
		    	var options = {'title':'',
		                       'width':500,
		                       'height':350,
		                       'thickness':8};
		        
		        var chart = new google.visualization.LineChart(document.getElementById('agg_calories_burned_chart_div'));
		        
		        if(numDays == 0){
		        	chart.draw(getAggCalorieData(), options);
		        }
		        else{
		        	getAggCalorieDataAJAX(numDays, options);
		        }
		    }
		    
		    function getHoursSleptData(){
		    	var data = new google.visualization.DataTable();
		        data.addColumn('date', 'Date');
		        data.addColumn('number', 'Hours Slept');
		        data.addRows([
		        	<g:each in="${data}">
		        		[new Date(${it.getDayYear()}, ${it.getDayMonth()}, ${it.getDayDay()}), ${it.hoursSlept}],
		        	</g:each>
		        ]);
		        
		        return data;
		    }
		    
		    function getHoursSleptDataAJAX(numDays, options){
		    	var url = '${createLink(controller:"Dashboard", action:"getDataAJAX")}?days=' + numDays;

				var chart = new google.visualization.LineChart(document.getElementById('hours_slept_chart_div'));
				
				var sleepData = new google.visualization.DataTable();
				sleepData.addColumn('date', 'Date');
				sleepData.addColumn('number', 'Hours Slept');
			
				$.getJSON(url, function(data) {
				        $.each(data, function(index) {
				        	var year = data[index].year;
				        	var month = data[index].month;
				        	var day = data[index].day;
							var hoursSlept = data[index].hoursSlept;
							var fullDate = new Date(year,month,day);
							
							sleepData.addRow([fullDate, hoursSlept]);
				        });
				        
				        chart.draw(sleepData, options);
				    });
		    }
		      
		    function drawHoursSleptChart(numDays) {
		    	var options = {'title':'',
		                       'width':500,
		                       'height':350};
	
		        // Instantiate and draw our chart, passing in some options.
		        var chart = new google.visualization.LineChart(document.getElementById('hours_slept_chart_div'));
		        
		        if(numDays == 0){
		        	chart.draw(getHoursSleptData(), options);
		        }
		        else{
		        	getHoursSleptDataAJAX(numDays, options);
		        }
		     }
		     
		     function getAggHoursSleptData(){
		     	var data = new google.visualization.DataTable();
		        data.addColumn('date', 'Date');
		        data.addColumn('number', 'Hours Slept');
		        data.addColumn('number', 'Team Average');
		        data.addColumn('number', 'Team Goal')
		        data.addRows([
		        	<g:each in="${data}">
		        		[new Date(${it.getDayYear()}, ${it.getDayMonth()}, ${it.getDayDay()}), ${it.hoursSlept}, ${it.getTeamAverageHoursSlept()}, ${it.getTeamHoursSleptGoal()}],
		        	</g:each>
		        ]);
		        
		        return data;	
		     }
		     
		     function getAggHoursSleptDataAJAX(numDays, options){
		     	var url = '${createLink(controller:"Dashboard", action:"getDataAJAX")}?days=' + numDays;

				var chart = new google.visualization.LineChart(document.getElementById('agg_hours_slept_chart_div'));
				
				var sleepData = new google.visualization.DataTable();
				sleepData.addColumn('date', 'Date');
				sleepData.addColumn('number', 'Hours Slept');
				sleepData.addColumn('number', 'Team Average');
				sleepData.addColumn('number', 'Team Goal');
			
				$.getJSON(url, function(data) {
				        $.each(data, function(index) {
				        	var year = data[index].year;
				        	var month = data[index].month;
				        	var day = data[index].day;
							var hoursSlept = data[index].hoursSlept;
							var teamAverage = data[index].teamAverageHoursSlept;
							var goal = data[index].hoursSleptGoal;
							var fullDate = new Date(year,month,day);
							
							sleepData.addRow([fullDate, hoursSlept, teamAverage, goal]);
				        });
				        
				        chart.draw(sleepData, options);
				    });
		     }
		      
		     function drawAggHoursSleptChart(numDays) {
		        var options = {'title':'',
		                       'width':500,
		                       'height':350};
	
		        // Instantiate and draw our chart, passing in some options.
		        var chart = new google.visualization.LineChart(document.getElementById('agg_hours_slept_chart_div'));
		        
		        if(numDays == 0){
		        	chart.draw(getAggHoursSleptData(), options);
		        }
		        else{
		        	getAggHoursSleptDataAJAX(numDays, options);
		        }
		      }
		      
		      function reloadCaloriesBurned(numDays){
				showCaloriesBurnedLoading();
				drawCaloriesBurnedChart(numDays);
				hideCaloriesBurnedLoading();
			  }
			  
			  function reloadHoursSlept(numDays){
			  	showHoursSleptLoading();
			  	drawHoursSleptChart(numDays);
			  	hideHoursSleptLoading();
			  }
			  
			  function reloadAggCaloriesBurned(numDays){
			  	showAggCaloriesBurnedLoading();
			  	drawAggCaloriesBurnedChart(numDays);
			  	hideAggCaloriesBurnedLoading();
			  }
			  
			  function reloadAggHoursSlept(numDays){
			  	showAggHoursSleptLoading();
			  	drawAggHoursSleptChart(numDays);
			  	hideAggHoursSleptLoading();
			  }
			
		</r:script>
	</head>
<body>
	<script type="text/javascript">

		function showCaloriesBurnedLoading(){
			$('#calories_burned_chart_div').html('');
			$('#caloriesBurnedContainer').hide();
			$('#caloriesBurnedLoading').fadeIn();
		}

		function hideCaloriesBurnedLoading(){
			$('#caloriesBurnedLoading').fadeOut(function(){
				$('#caloriesBurnedContainer').fadeIn();
			});
		}

		function showAggCaloriesBurnedLoading(){
			$('#agg_calories_burned_chart_div').html('');
			$('#aggCaloriesBurnedContainer').hide();
			$('#aggCaloriesBurnedLoading').fadeIn();
		}

		function hideAggCaloriesBurnedLoading(){
			$('#aggCaloriesBurnedLoading').fadeOut(function(){
				$('#aggCaloriesBurnedContainer').fadeIn();
			});
		}

		function showHoursSleptLoading(){
			$('#hours_slept_chart_div').html('');
			$('#hoursSleptContainer').hide();
			$('#hoursSleptLoading').fadeIn();
		}

		function hideHoursSleptLoading(){
			$('#hoursSleptLoading').fadeOut(function(){
				$('#hoursSleptContainer').fadeIn();
			});
		}

		function showAggHoursSleptLoading(){
			$('#agg_hours_slept_chart_div').html('');
			$('#aggHoursSleptContainer').hide();
			$('#aggHoursSleptLoading').fadeIn();
		}

		function hideAggHoursSleptLoading(){
			$('#aggHoursSleptLoading').fadeOut(function(){
				$('#aggHoursSleptContainer').fadeIn();
			});
		}
	
	</script>
	<div id="tabSet" style="margin-left:10px; margin-right:7px;">
  		<ul id="navList">
	  		<li id="tabs-1-selector" class="selected">
	  			<a href="javascript:switchTabs(this, 'tabs-1');">
	  				My Data
	  			</a>
	  		</li>
	  		<li id="tabs-2-selector">
	  			<a href="javascript:switchTabs(this, 'tabs-2');">
	  				My Team Data
	  			</a>
	  		</li>
	  		<li id="tabs-3-selector">
	  			<a href="javascript:switchTabs(this, 'tabs-3');">
	  				My Workout Calendar
	  			</a>
	  		</li>
	  	</ul>
	  	<div id="tabContent">
		  	<div class="contentTab" id="tabs-1">
		  		<span style="position:absolute;left:5%;top:8%;width:40%;font-size:20pt;font-weight:bold;">Calories Burned</span>
		  		<div id="caloriesBurned" style="position:absolute;left:5%;top:15%;width:40%;height:400px;border:2px solid #C0C0C0;">
		  			<span id="caloriesBurnedButtonDiv" style="position:absolute;left:0;top:0;margin-left:2%;margin-top:1%;">
						<input type="button" onClick="reloadCaloriesBurned(7);" value="1 Week" style="cursor:pointer;"/>
						<input type="button" onClick="reloadCaloriesBurned(14);" value="2 Weeks" style="cursor:pointer;"/>
						<input type="button" onClick="reloadCaloriesBurned(30);" value="1 Month" style="cursor:pointer;"/><br/>
						<img id="caloriesBurnedLoading" src="${resource(dir: 'images', file: 'spinner.gif')}" style="display:none;"/>
					</span>
		  			<div id="caloriesBurnedContainer" style="height:91%;width:100%;bottom:0;position:absolute;">
		  				<div id="calories_burned_chart_div"></div>
		  			</div>
		  		</div>
		  		
		  		<span style="position:absolute;left:50%;top:8%;width:40%;font-size:20pt;font-weight:bold;">Hours Slept</span>
		  		<div id="hoursSlept" style="display:inline;position:absolute;left:50%;top:15%;width:40%;height:400px; border:2px solid #C0C0C0;">
		  			<span id="hoursSleptButtonDiv" style="position:absolute;left:0;top:0; margin-left:2%;margin-top:1%;">
		  				<input type="button" onClick="reloadHoursSlept(7);" value="1 Week" style="cursor:pointer;"/>
		  				<input type="button" onClick="reloadHoursSlept(14);" value="2 Weeks" style="cursor:pointer;"/>
		  				<input type="button" onClick="reloadHoursSlept(30);" value="1 Month" style="cursor:pointer;"/>
		  				<img id="hoursSleptLoading" src="${resource(dir: 'images', file: 'spinner.gif')}" style="display:none;"/>
		  			</span>
		  			<div id="hoursSleptContainer" style="height:91%;width:100%;bottom:0; position:absolute;">
		  				<div id="hours_slept_chart_div"></div>
		  			</div>
		  		</div>
		  	</div>
		  	<div class="contentTab" id="tabs-2" style="display:none;">
		  		<span style="position:absolute;left:5%;top:8%;width:40%;font-size:20pt;font-weight:bold;">Calories Burned</span>
		  		<div id="aggCaloriesBurned" style="position:absolute;left:5%;top:15%;width:40%;height:400px;border:2px solid #C0C0C0;">
		  			<span id="aggCaloriesBurnedButtonDiv" style="position:absolute;left:0;top:0;margin-left:2%;margin-top:1%;">
		  				<input type="button" onClick="reloadAggCaloriesBurned(7);" value="1 Week" style="cursor:pointer;"/>
		  				<input type="button" onClick="reloadAggCaloriesBurned(14);" value="2 Weeks" style="cursor:pointer;"/>
		  				<input type="button" onClick="reloadAggCaloriesBurned(30);" value="1 Month" style="cursor:pointer;"/>
		  				<img id="aggCaloriesBurnedLoading" src="${resource(dir: 'images', file: 'spinner.gif')}" style="display:none;"/>
		  			</span>
		  			<div id="aggCaloriesBurnedContainer" style="height:91%;width:100%;bottom:0;position:absolute;">
		  				<div id="agg_calories_burned_chart_div"></div>
		  			</div>
		  		</div>
		  		
		  		<span style="position:absolute;left:50%;top:8%;width:40%;font-size:20pt;font-weight:bold;">Hours Slept</span>
		  		<div id="aggHoursSlept" style="display:inline;position:absolute;left:50%;top:15%;width:40%;height:400px; border:2px solid #C0C0C0;">
		  			<span id="aggHoursSleptButtonDiv" style="position:absolute;left:0;top:0;margin-left:2%;margin-top:1%;">
		  				<input type="button" onClick="reloadAggHoursSlept(7);" value="1 Week" style="cursor:pointer;"/>
		  				<input type="button" onClick="reloadAggHoursSlept(14);" value="2 Weeks" style="cursor:pointer;"/>
		  				<input type="button" onClick="reloadAggHoursSlept(30);" value="1 Month" style="cursor:pointer;"/>
		  				<img id="aggHoursSleptLoading" src="${resource(dir: 'images', file: 'spinner.gif')}" style="display:none;"/>
		  			</span>
		  			<div id="aggHoursSleptContainer" style="height:91%;width:100%;bottom:0;position:absolute;">
		  				<div id="agg_hours_slept_chart_div"></div>
		  			</div>
		  		</div>
		  	</div>
		  	<div class="contentTab" id="tabs-3" style="display:none;">
		  		<div id="calendar" style="position:absolute;left:10%;top:10%;width:80%;height:100%;"></div>
		  	</div>
		</div>
	</div>
</body>
</html>