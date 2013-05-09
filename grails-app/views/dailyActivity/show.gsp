
<%@ page import="com.conditioncoach.DailyActivity" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'dailyActivity.label', default: 'DailyActivity')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-dailyActivity" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-dailyActivity" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list dailyActivity">
			
				<g:if test="${dailyActivityInstance?.activityDescription}">
				<li class="fieldcontain">
					<span id="activityDescription-label" class="property-label"><g:message code="dailyActivity.activityDescription.label" default="Activity Description" /></span>
					
						<span class="property-value" aria-labelledby="activityDescription-label"><g:fieldValue bean="${dailyActivityInstance}" field="activityDescription"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${dailyActivityInstance?.endDate}">
				<li class="fieldcontain">
					<span id="endDate-label" class="property-label"><g:message code="dailyActivity.endDate.label" default="End Date" /></span>
					
						<span class="property-value" aria-labelledby="endDate-label"><g:formatDate date="${dailyActivityInstance?.endDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${dailyActivityInstance?.startDate}">
				<li class="fieldcontain">
					<span id="startDate-label" class="property-label"><g:message code="dailyActivity.startDate.label" default="Start Date" /></span>
					
						<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${dailyActivityInstance?.startDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${dailyActivityInstance?.team}">
				<li class="fieldcontain">
					<span id="team-label" class="property-label"><g:message code="dailyActivity.team.label" default="Team" /></span>
					
						<span class="property-value" aria-labelledby="team-label"><g:link controller="team" action="show" id="${dailyActivityInstance?.team?.id}">${dailyActivityInstance?.team?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${dailyActivityInstance?.id}" />
					<g:link class="edit" action="edit" id="${dailyActivityInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
