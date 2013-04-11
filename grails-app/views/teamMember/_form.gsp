<%@ page import="com.conditioncoach.TeamMember" %>



<div class="fieldcontain ${hasErrors(bean: teamMemberInstance, field: 'birthDate', 'error')} required">
	<label for="birthDate">
		<g:message code="teamMember.birthDate.label" default="Birth Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="birthDate" precision="day"  value="${teamMemberInstance?.birthDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: teamMemberInstance, field: 'firstName', 'error')} ">
	<label for="firstName">
		<g:message code="teamMember.firstName.label" default="First Name" />
		
	</label>
	<g:textField name="firstName" value="${teamMemberInstance?.firstName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamMemberInstance, field: 'lastName', 'error')} ">
	<label for="lastName">
		<g:message code="teamMember.lastName.label" default="Last Name" />
		
	</label>
	<g:textField name="lastName" value="${teamMemberInstance?.lastName}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamMemberInstance, field: 'team', 'error')} required">
	<label for="team">
		<g:message code="teamMember.team.label" default="Team" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="team" name="team.id" from="${com.conditioncoach.Team.list()}" optionKey="id" required="" value="${teamMemberInstance?.team?.id}" class="many-to-one"/>
</div>

<div class="fieldcontain ${hasErrors(bean: teamMemberInstance, field: 'user', 'error')} required">
	<label for="user">
		<g:message code="teamMember.user.label" default="User" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="user" name="user.id" from="${com.conditioncoach.usersec.User.list()}" optionKey="id" required="" value="${teamMemberInstance?.user?.id}" class="many-to-one"/>
</div>

