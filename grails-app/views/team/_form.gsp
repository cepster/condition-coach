<%@ page import="com.conditioncoach.Team" %>

<div class="required">
	<label for="name">
		<g:message code="team.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${teamInstance?.name}"/>
</div>

<br/><br/>

<div>
	<label for="avatar">
		Change Avatar
	</label>
	<input type="file" id="avatar" name="avatar" value="${teamInstance?.avatar}"/>
	<input type="hidden" id="id" name="id" value="${teamInstance?.id}"/>
</div>





