
<%@ page import="com.conditioncoach.TeamMember" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'teamMember.label', default: 'TeamMember')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-teamMember" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/Dashboard')}">Dashboard</a></li>
			</ul>
		</div>
		<div id="show-teamMember" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list teamMember">
			
				<g:if test="${teamMemberInstance?.birthDate}">
				<li class="fieldcontain">
					<span id="birthDate-label" class="property-label"><g:message code="teamMember.birthDate.label" default="Birth Date" /></span>
					
						<span class="property-value" aria-labelledby="birthDate-label"><g:formatDate date="${teamMemberInstance?.birthDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${teamMemberInstance?.firstName}">
				<li class="fieldcontain">
					<span id="firstName-label" class="property-label"><g:message code="teamMember.firstName.label" default="First Name" /></span>
					
						<span class="property-value" aria-labelledby="firstName-label"><g:fieldValue bean="${teamMemberInstance}" field="firstName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teamMemberInstance?.lastName}">
				<li class="fieldcontain">
					<span id="lastName-label" class="property-label"><g:message code="teamMember.lastName.label" default="Last Name" /></span>
					
						<span class="property-value" aria-labelledby="lastName-label"><g:fieldValue bean="${teamMemberInstance}" field="lastName"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${teamMemberInstance?.team}">
				<li class="fieldcontain">
					<span id="team-label" class="property-label"><g:message code="teamMember.team.label" default="Team" /></span>
					
						<span class="property-value" aria-labelledby="team-label">${teamMemberInstance?.team?.name?.encodeAsHTML()}</span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form>
				<fieldset class="buttons">
					<g:hiddenField name="id" value="${teamMemberInstance?.id}" />
					<g:link class="edit" action="edit" id="${teamMemberInstance?.id}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
