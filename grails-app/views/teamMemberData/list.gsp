
<%@ page import="com.conditioncoach.TeamMemberData" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'teamMemberData.label', default: 'TeamMemberData')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<script type="text/javascript">
			$(document).ready(function(){
				$('input[type=radio]').click(function(){
					var url = '${createLink(controller:"TeamMemberData", action:"getPlayerAggData")}?id=' + $(this).attr('value');
<%--					alert(url);--%>
					$.getJSON(url, function(data) {
						$('#calories').empty().append(data.calories);
						$('#hoursSlept').empty().append(data.hoursSlept);
				    });
				});
			});

		</script>
		<a href="#list-teamMemberData" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="list-teamMemberData" class="content scaffold-list" role="main">
			<h1>Choose member to view</h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table style="height:300px;">
				<thead>
					<tr>
						<td><b>Member Name</b></td>
					</tr>
				</thead>
				<tbody>
				<g:each in="${teamMemberInstanceList}" status="i" var="teamMemberInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
						<td><input type="radio" id="player" name="player" value="${teamMemberInstance?.id}"/>${" " + teamMemberInstance?.firstName + " " + teamMemberInstance?.lastName}</td>
					</tr>
				</g:each>
				</tbody>
			</table>
			<div id="memberData">
				<b>Average Calories:</b> <p id="calories"></p><br/>
				<b>Average Hours Slept:</b> <p id="hoursSlept"></p><br/>
			</div>
		</div>
	</body>
</html>
