<%@ page import="com.conditioncoach.Team" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'team.label', default: 'Team')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
<%--		<g:javascript library='jquery' />--%>
<%--		<g:javascript library='jquery-ui'/>--%>
		<r:require module="jquery"/>
		<g:javascript src='jquery.tablesorter.min.js'/>
<%--		<r:require module="jquery-ui"/>--%>
	</head>
	<body>
		<script type="text/javascript">
			$(document).ready(function(){
				$('#addMemberDiv').dialog({
					title: 'Add Member To Team',
					autoOpen:false,
					height:400,
					width:500,
					show:'scale',
					hide:'scale',
					buttons: [
					{id:"submit",
					 text: "Submit",
					 click: function(){
							addTeamMember();
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

<%--				$('#memberTable').tablesorter();--%>
			});

			function addTeamMember(){
				var firstName = $('#firstName').val();
				var lastName = $('#lastName').val();
				var email = $('#email').val();

				$('#memberTable thead').append('<tr><td>' + firstName + ' ' + lastName + '</td><td>' + email + '</td><td>Invitation Sent</td></tr>');

				//TODO Save member AJAX call
				
				$('#addMemberDiv').dialog('close');
			}

			function deleteTeamMember(){
				//TODO Delete member AJAX call
			}
		</script>
		<a href="#edit-team" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-team" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${teamInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${teamInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form method="post" >
				<g:hiddenField name="id" value="${teamInstance?.id}" />
				<g:hiddenField name="version" value="${teamInstance?.version}" />
				<fieldset class="form">
					<g:render template="form"/>
					<br/>
					<br/>
					<table id="memberTable" name="memberTable" class="tablesorter">
						<thead>
							<tr>
								<th>Name</th>
								<th>Email Address</th>
								<th>Status</th>
							</tr>
						</thead>
						<tbody>
						
						</tbody>
					</table>
					<br/>
					<br/>
					<input type="button" id="addMember" name="addMember" value="Add Team Member" onclick="$('#addMemberDiv').dialog('open')"/>
					<div id="addMemberDiv" name="addMemberDiv" style="display:none;">
						First Name<br/>
						<input type="text" id="firstName" name="firstName"/>
						<br/><br/>
						Last Name<br/>
						<input type="text" id="lastName" name="lastName"/>
						<br/>
						<br/>
						Email Address<br/>
						<input type="text" id="email" name="email"/>
						<br/>
					</div>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" formnovalidate="" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
