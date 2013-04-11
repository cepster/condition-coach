
<%@ page import="com.conditioncoach.TeamMember" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'teamMember.label', default: 'TeamMember')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-teamMember" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-teamMember" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<table>
				<thead>
					<tr>
					
						<g:sortableColumn property="birthDate" title="${message(code: 'teamMember.birthDate.label', default: 'Birth Date')}" />
					
						<g:sortableColumn property="firstName" title="${message(code: 'teamMember.firstName.label', default: 'First Name')}" />
					
						<g:sortableColumn property="lastName" title="${message(code: 'teamMember.lastName.label', default: 'Last Name')}" />
					
						<th><g:message code="teamMember.team.label" default="Team" /></th>
					
						<th><g:message code="teamMember.user.label" default="User" /></th>
					
					</tr>
				</thead>
				<tbody>
				<g:each in="${teamMemberInstanceList}" status="i" var="teamMemberInstance">
					<tr class="${(i % 2) == 0 ? 'even' : 'odd'}">
					
						<td><g:link action="show" id="${teamMemberInstance.id}">${fieldValue(bean: teamMemberInstance, field: "birthDate")}</g:link></td>
					
						<td>${fieldValue(bean: teamMemberInstance, field: "firstName")}</td>
					
						<td>${fieldValue(bean: teamMemberInstance, field: "lastName")}</td>
					
						<td>${fieldValue(bean: teamMemberInstance, field: "team")}</td>
					
						<td>${fieldValue(bean: teamMemberInstance, field: "user")}</td>
					
					</tr>
				</g:each>
				</tbody>
			</table>
			<div class="pagination">
				<g:paginate total="${teamMemberInstanceTotal}" />
			</div>
		</div>
	</body>
</html>
