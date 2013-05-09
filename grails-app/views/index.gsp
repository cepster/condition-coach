<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main"/>
		<title>Condition Coach</title>
		<style type="text/css" media="screen">
			#status {
				background-color: #eee;
				border: .2em solid #fff;
				margin: 2em 2em 1em;
				padding: 1em;
				width: 12em;
				float: left;
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;
			}

			.ie6 #status {
				display: inline; /* float double margin fix http://www.positioniseverything.net/explorer/doubled-margin.html */
			}

			#status ul {
				font-size: 0.9em;
				list-style-type: none;
				margin-bottom: 0.6em;
				padding: 0;
			}

			#status li {
				line-height: 1.3;
			}

			#status h1 {
				text-transform: uppercase;
				font-size: 1.1em;
				margin: 0 0 0.3em;
			}

			#page-body {
				margin: 2em 1em 1.25em 18em;
			}

			h2 {
				margin-top: 1em;
				margin-bottom: 0.3em;
				font-size: 1em;
			}

			p {
				line-height: 1.5;
				margin: 0.25em 0;
			}

			#controller-list ul {
				list-style-position: inside;
			}

			#controller-list li {
				line-height: 1.3;
				list-style-position: inside;
				margin: 0.25em 0;
			}

			@media screen and (max-width: 480px) {
				#status {
					display: none;
				}

				#page-body {
					margin: 0 1em 1em;
				}

				#page-body h1 {
					margin-top: 0;
				}
			}
			
			.navTable {
				border-top:0px !important;
			}
			
			.navTable th:hover, tr:hover {
				background-color: #FFFFFF;
			}
			
			.navTable a{
				text-decoration:none;
				text-align:center;
			}
			
			.navAlt{
				text-decoration:none;
				font-size:28pt;
				display:none;
			}
			
			#goalsDiv{
				border: 1px rgba(0,0,0,0.45);
				border-left:1px solid gray;
				padding-left:10px;
			}
			
			#goalsContent{
				-moz-box-shadow: 0px 0px 1.25em #ccc;
				-webkit-box-shadow: 0px 0px 1.25em #ccc;
				box-shadow: 0px 0px 1.25em #ccc;
				-moz-border-radius: 0.6em;
				-webkit-border-radius: 0.6em;
				border-radius: 0.6em;	
				padding-left:5px;
				padding-right:5px;
				height:auto;
				width:380px;
				background-color:#C9C9C9;
				font-size:20pt;
<%--				margin:0 auto;--%>
			}
			
		</style>
		<r:require module="jquery"/>
		<script type="text/javascript">

			var cachedBGImage;
		
			function showAlt(name){
				$('#myDiv').css('background-image')
				cachedBGImage = $('#' + name + 'Div').css('background-image');
				$('#' + name + 'Div').css('background-image', 'none');
				$('#' + name + 'DivAlt').show();
			}

			function showPrimary(name){
				$('#' + name + 'DivAlt').hide();
				$('#' + name + 'Div').css('background-image', cachedBGImage);
			}

		</script>
	</head>
	<body>
		<sec:ifAllGranted roles="ROLE_TEAMMEMBER">
			<script type="text/javascript">
				var goalsArray = new Array();
				var currentIndex = 0;
				
				$(document).ready(function(){
					var url = '${createLink(controller:'teamGoal', action:'getGoalsByMember');}';

					$.getJSON(url, function(data) {
				        $.each(data, function(index) {
							var text = data[index].goalDate.substring(0,10) + ": " + data[index].goalDescription;
				            goalsArray[goalsArray.length] = text; 
				            if(index == 0){
								$('#goalsContent').empty().append(text);
						    }
				        });
				    });
				});

				window.setInterval(function(){
					if(currentIndex == goalsArray.length-1){
						currentIndex = 0;
					}
					else{
						currentIndex = currentIndex+1;
					}

					$('#goalsContent').empty().append(goalsArray[currentIndex])
				},3000);
			</script>
		</sec:ifAllGranted>
		<a href="#page-body" class="skip"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="navButtonsDiv" style="margin-left:20px;margin-right:20px;margin-top:20px;">
			<table class="navTable">
				<sec:ifLoggedIn>
					<sec:ifAllGranted roles="ROLE_COACH">
						<tr>
							<td>
								<g:link controller="dailyActivity" action="list">
									<div id="teamCalendarDiv" class="navButton" style="background-image:url(images/teamCalendar.png);" onMouseOver="showAlt('teamCalendar');" onMouseOut="showPrimary('teamCalendar');">
										<div id="teamCalendarDivAlt" class="navAlt">
											Team Calendar
										</div>
									</div>
								</g:link>
							</td>
							<td>
								<g:link controller="team" action="edit">
									<div id="editTeamDiv" class="navButton" style="background-image:url(images/gearIcon.png);" onMouseOver="showAlt('editTeam');" onMouseOut="showPrimary('editTeam');">
										<div id="editTeamDivAlt" class="navAlt">
											Edit Team
										</div>
									</div>
								</g:link>
							</td>
						</tr>
						<tr>
							<td>
								<g:link controller="teamGoal" action="listAdmin">
									<div id="editGoalsDiv" class="navButton" style="background-image:url(images/teamGoal.png);" onMouseOver="showAlt('editGoals');" onMouseOut="showPrimary('editGoals');">
										<div id="editGoalsDivAlt" class="navAlt">
											Team Goals										
										</div>
									</div>
								</g:link>
							</td>
							<td>
								<g:link controller="teamMemberData" action="list">
									<div id="teamMemberDataDiv" class="navButton" style="background-image:url(images/data.png);" onMouseOver="showAlt('teamMemberData');" onMouseOut="showPrimary('teamMemberData')">
										<div id="teamMemberDataDivAlt" class="navAlt">
											View Team Data
										</div>
									</div>
								</g:link>
							</td>
						</tr>
					</sec:ifAllGranted>
					<sec:ifAllGranted roles="ROLE_TEAMMEMBER">
						<tr>
							<td>
								<g:link controller="dashboard" action="index">
									<div id="dashboardDiv" class="navButton" style="background-image:url(images/dashboard.png);" onMouseOver="showAlt('dashboard')" onMouseOut="showPrimary('dashboard');">
										<div id="dashboardDivAlt" class="navAlt">
											My Dashboard
										</div>
									</div>
								</g:link>
							</td>
							<td>
								<g:link controller="teamMember" action="edit">
									<div id="editProfileDiv" class="navButton" style="background-image:url(images/gearIcon.png);" onMouseOver="showAlt('editProfile');" onMouseOut="showPrimary('editProfile');">
										<div id="editProfileDivAlt" class="navAlt">
											Edit Profile
										</div>
									</div>
								</g:link>
							</td>
						</tr>
					</sec:ifAllGranted>
				</sec:ifLoggedIn>
				<sec:ifNotLoggedIn>
					<tr>
						<td>
							<g:link controller="login" action="auth">
								<div id="loginDiv" class="navButton" style="background-image:url(images/login.png);" onMouseOver="showAlt('login')" onMouseOut="showPrimary('login');">
									<div id="loginDivAlt" class="navAlt">
										Login
									</div>
								</div>
							</g:link>
						</td>
						<td>
							<g:link controller="login" action="register">
								<div class="navButtonsEmpty" onMouseOver="showAlt('register')" onMouseOut="showPrimary('register');">
									<div id="registerDiv" class="navButton" style="background-image:url(images/register.png);">
										<div id="registerDivAlt" class="navAlt">
											Register New Team
										</div>
									</div>
								</div>
							</g:link>
						</td>
					</tr>
				</sec:ifNotLoggedIn>
			</table>
			<sec:ifAllGranted roles="ROLE_TEAMMEMBER">
				<div id="goalsDiv" style="height:300px;width:420px;position:absolute;right:250px;top:20px;font-size:40pt;">
					Goals
					<div id="goalsContent">
					</div>
				</div>
			</sec:ifAllGranted>
		</div>
	</body>
</html>
