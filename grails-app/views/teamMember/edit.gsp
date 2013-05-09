<%@ page import="com.conditioncoach.TeamMember" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'teamMember.label', default: 'Profile')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<g:javascript library="jquery"/>
	</head>
	<body>
		<a href="#edit-teamMember" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div id="edit-teamMember" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${teamMemberInstance}">
				<ul class="errors" role="alert">
					<g:eachError bean="${teamMemberInstance}" var="error">
					<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
					</g:eachError>
				</ul>
			</g:hasErrors>
			<g:form method="post" enctype="multipart/form-data">
				<g:hiddenField name="id" value="${teamMemberInstance?.id}" />
				<g:hiddenField name="version" value="${teamMemberInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="save" value="${message(code: 'default.button.update.label', default: 'Save Profile')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
