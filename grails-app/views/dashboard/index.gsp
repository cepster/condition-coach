<%@ page contentType="text/html;charset=UTF-8" %>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
		<meta name="layout" content="main"/>
		<title>My Dashboard</title>
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'dashboard.css')}" type="text/css">
		<r:require module="full-calendar"/>
		<r:script>
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
						{
							title: 'Football Camp',
							start: new Date(y, m, 1)
						},
						{
							title: 'Two-a-days',
							start: new Date(y, m, d-5),
							end: new Date(y, m, d-2)
						},
						{
							id: 999,
							title: 'Weight Training',
							start: new Date(y, m, d-3, 16, 0),
							allDay: false
						},
						{
							id: 999,
							title: 'Cardio',
							start: new Date(y, m, d+4, 16, 0),
							allDay: false
						},
						{
							title: 'Yoga',
							start: new Date(y, m, d, 10, 30),
							allDay: false
						},
						{
							title: 'Team Lunch',
							start: new Date(y, m, d, 12, 0),
							end: new Date(y, m, d, 14, 0),
							allDay: false
						},
						{
							title: 'Scrimmage',
							start: new Date(y, m, d+1, 19, 0),
							end: new Date(y, m, d+1, 22, 30),
							allDay: false
						}
					]
				});
			});
		
			function switchTabs(link, tabName){
				$('#tabContent div[class=contentTab]').hide()
				$('#' + tabName).show()
				$('li').removeClass('selected');			
				$('#' + tabName + '-selector').addClass('selected');
			}
		</r:script>
	</head>
<body>
	<div id="tabSet" style="margin-left:10px; margin-right:7px;">
  		<ul id="navList" name="navList">
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
		  		<div id="caloriesBurned" style="position:absolute;left:5%;top:10%;width:45%;">
		  			<img src="${resource(dir: 'images', file: 'weightLoss.jpg')}" style="border:2px solid #C0C0C0;"/>
		  		</div>
		  		<div id="hoursSlept" style="display:inline;position:absolute;left:50%;top:10%;width:60%;">
		  			<img src="${resource(dir: 'images', file: 'calories.jpg')}" style="border:2px solid #C0C0C0; width:60%"/>
		  		</div>
		  	</div>
		  	<div class="contentTab" id="tabs-2" style="display:none;">
		  		<div id="genericBarGraph" style="position:absolute;left:10%;top:10%;width:80%;height:100%;">
		  			<img src="${resource(dir: 'images', file: 'barGraph.jpg')}" style="border:2px solid #C0C0C0; width:80%; height:80%;"/>
		  		</div>
		  	</div>
		  	<div class="contentTab" id="tabs-3" style="display:none;">
		  		<div id="calendar" style="position:absolute;left:10%;top:10%;width:80%;height:100%;"></div>
		  	</div>
		</div>
	</div>
</body>
</html>