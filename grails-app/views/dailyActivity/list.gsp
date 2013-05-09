<%@ page import="com.conditioncoach.DailyActivity" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'dailyActivity.label', default: 'DailyActivity')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
		<r:require module="full-calendar"/>
		<r:script passthrough="true">
			$(document).ready(function(){
				
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
				
				$('#calendar').fullCalendar( 'rerenderEvents' )
				
				$('#startDate').datepicker();
				$('#endDate').datepicker();
			});
		</r:script>
	</head>
	<body>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#addEventDiv').dialog({
					title: 'Add New Team Event',
					autoOpen:false,
					height:450,
					width:500,
					show:'scale',
					hide:'scale',
					buttons: [
					{id:"submit",
					 text: "Submit",
					 click: function(){
							addEvent();
						}
					},
					{id:"cancel",
					 text: "Cancel",
					 click: function(){
						$(this).dialog('close');
						}
					}
					]
				});
			});

			function addEvent(){
				${remoteFunction(
					controller:'DailyActivity',
					action:'save',
					params: '$("#addEventForm").serialize()',
					onComplete:'$("#addEventDiv").dialog("close");location.reload();'
				)}
			}
		</script>
		<input type="button" onClick="$('#addEventDiv').dialog('open');" value="Add Event"/><br/>
		<div id="calendar" style="position:absolute;top:40px;width:80%;height:100%;"></div>
		<div id="addEventDiv" style="display:none;">
			<form id="addEventForm" name="addEventForm">
				<table>
					<tr>
						<td>
							Start Date
						</td>
						<td>
							<input id="startDate" name="startDate"/>
						</td>
					</tr>
					<tr>
						<td>
							End Date
						</td>
						<td>
							<input id="endDate" name="endDate"/>
						</td>
					</tr>
					<tr>
						<td>
							Description
						</td>
						<td>
							<textArea id="activityDescription" name="activityDescription"></textArea>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
