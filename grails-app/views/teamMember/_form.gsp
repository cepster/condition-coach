<%@ page import="com.conditioncoach.TeamMember" %>

<script type="text/javascript">
	$(document).ready(function(){
		$('#birthDate').datepicker();

		$('#updatePicture').click(function(){
			${remoteFunction(
				controller:'TeamMember',
				action:'updateAvatar',
				params: '$("#pictureForm").serialize()',
				onComplete:'alert("complete");'
			)}
		});

		$('#passwordChangeDiv').dialog({
			title: 'Change Password',
			autoOpen:false,
			height:400,
			width:600,
			show:'scale',
			hide:'scale',
			buttons: [
			{id:"submit",
			 text: "Submit",
			 click: function(){
				 clearValidations();
				 validateNewPasswords();
				}
			},
			{id:"cancel",
			 text: "Cancel",
			 click: function(){
				$(this).dialog('close');
				}
			}]
		});
	});

	function clearValidations(){
		$('#noAuth').hide();
		$('#noMatch').hide();
	}

	function clearPasswordForm(){
		clearValidations();
		$('#existingPassword').val('');
		$('#newPassword').val('');
		$('#confirmPassword').val('');
	}

	function validateNewPasswords(){
		//Validate existing password
		var existPW = $('#existingPassword').val();
		var url = '${createLink(controller:"TeamMember", action:"checkPWValidity")}?password=' + existPW;

		var valid = true;
		
		$.ajax(url)
			.done(function(data){
				var valid = eval(data).valid;
				if(!valid){
					$('#noAuth').show();	
					valid = false;
				}
				//Check to see if they are equal
				var newPW = $('#newPassword').val()
				var confPW = $('#confirmPassword').val()
				if(newPW != confPW){
					$('#noMatch').show();
					valid = false;
				}

				if(valid){
					changePassword();
				}
			})
			.fail(function(message){
				alert('error: ' + message);
			});
	}

	function changePassword(){
		${remoteFunction(
			controller:'TeamMember',
			action:'changePassword',
			params: '"newPassword=" + $("#newPassword").val()',
			onComplete:'alert("Your password has been changed"); $("#passwordChangeDiv").dialog("close");clearPasswordForm();'
		)}
	}

</script>

<div class="fieldcontain ${hasErrors(bean: teamMemberInstance, field: 'firstName', 'error')} required">
	<label for="firstName">
		<g:message code="teamMember.firstName.label" default="First Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="firstName" value="${teamMemberInstance?.firstName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamMemberInstance, field: 'lastName', 'error')} required">
	<label for="lastName">
		<g:message code="teamMember.lastName.label" default="Last Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="lastName" value="${teamMemberInstance?.lastName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamMemberInstance, field: 'birthDate', 'error')} required">
	<label for="birthDate">
		<g:message code="teamMember.birthDate.label" default="Birth Date" />
		<span class="required-indicator">*</span>
	</label>
	<input id="birthDate" name="birthDate" value="${teamMemberInstance?.birthDate}"/>
</div>

<div class="fieldcontain">
	<label>
		Password
	</label>
	<a href="javascript:$('#passwordChangeDiv').dialog('open');">Change Password</a>
</div>

<br/><br/>

<div class="fieldcontain ${hasErrors(bean: teamMemberInstance, field: 'nikeUserName', 'error')}">
	<label for="nikeUserName">
		<g:message code="teamMember.nikeUserName.label" default="Nike Username" />
	</label>
	<input type="text" id="nikeUserName" name="nikeUserName" value="${teamMemberInstance?.nikeUserName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamMemberInstance, field: 'nikePassword', 'error')}">
	<label for="nikePassword">
		<g:message code="teamMember.nikePassword.label" default="Nike Password" />
	</label>
	<input type="text" id="nikePassword" name="nikePassword" value="${teamMemberInstance?.nikePassword}"/>
</div>
<br/><br/>
<div class="fieldcontain">
	<label for="avatar">
		Change Avatar
	</label>
	<input type="file" id="avatar" name="avatar" value="${teamMemberInstance?.avatar}"/>
	<input type="hidden" id="id" name="id" value="${teamMemberInstance?.id}"/>
</div>

<div id="passwordChangeDiv" style="display:none;">
	<table>
		<tr id="noMatch" style="display:none;color:red;">
			<td>
				***Passwords do not match***
			</td>
		</tr>
		<tr id="noAuth" style="display:none;color:red;">
			<td>
				***Existing password is incorrect***
			</td>
		</tr>
		<tr>
			<td>
				Existing Password
			</td>			
			<td>
				<input type="password" class="_text" id="existingPassword" name="existingPassword"/>	
			</td>
		</tr>
		<tr>
			<td>
				New Password
			</td>
			<td>
				<input type="password" class="_text" id="newPassword" name="newPassword"/>			
			</td>
		</tr>
		<tr>
			<td>
				Confirm Password
			</td>
			<td>
				<input type="password" class="_text" id="confirmPassword" name="confirmPassword"/>
			</td>
		</tr>
	</table>
</div>

