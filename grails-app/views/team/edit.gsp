<%@ page import="com.conditioncoach.Team" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'team.label', default: 'Team')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>
		<r:require module="jquery"/>
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
			});

			function addTeamMember(){
				var firstName = $('#firstName').val();
				var lastName = $('#lastName').val();
				var email = $('#email').val();
				var teamID = '${teamInstance?.id}';

				$('#firstName').val('');
				$('#lastName').val('');
				$('#email').val('');

				${remoteFunction(
						controller:'Team',
						action:'addTeamMember',
						params: '\'teamID=\' + teamID + \'&firstName=\' + firstName + \'&lastName=\' + lastName + \'&email=\' + email',
						onSuccess:'addTeamMemberRow(data);$("#addMemberDiv").dialog("close");')};
			}

			function addTeamMemberRow(data){
				$('#memberTable thead').append('<tr><td>' + data.firstName + ' ' + data.lastName + '</td>' + 
												   '<td>' + data.email + '</td>' + 
												   '<td>Invitation Sent</td>' +
												   '<td align="center"><a href="javascript:deleteTeamMember(' + data.id + ');"><img src="' + '${resource(dir: 'images', file: 'delete.png')}' + '"/></a></td>');
			}

			function deleteTeamMember(id){
				if(confirm('Remove Team Member from Team?  This cannot be undone')){
					${remoteFunction(
						controller:'Team',
						action:'removeTeamMember',
						params: '\'memberID=\' + id',
						onComplete:'var url = \'' + createLink(controller: "team", action: "edit", id: teamInstance?.id) + '\'; window.location.href=url;'	
					)};
				}
			}
		</script>
		<a href="#edit-team" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
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
			<g:form method="post" enctype="multipart/form-data">
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
								<th>Delete Member</th>
							</tr>
						</thead>
						<tbody>
							<g:each in="${teamInstance?.teamMembers}">
								<tr>
									<td>${it?.firstName + " " + it?.lastName}</td>
									<td>${it?.email}</td>
									<td>${it?.getStatusName()}</td>
									<td align="center"><a href="javascript:deleteTeamMember('${it?.id}');"><img src="${resource(dir: 'images', file: 'delete.png')}"/></a></td>
								</tr>
							</g:each>
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
					<g:actionSubmit class="save" action="save" value="${message(code: 'default.button.update.label', default: 'Save Team')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
