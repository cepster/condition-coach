<%@ page import="com.conditioncoach.DailyActivity" %>



<div class="fieldcontain ${hasErrors(bean: dailyActivityInstance, field: 'activityDescription', 'error')} ">
	<label for="activityDescription">
		<g:message code="dailyActivity.activityDescription.label" default="Activity Description" />
		
	</label>
	<g:textField name="activityDescription" value="${dailyActivityInstance?.activityDescription}"/>
</div>

<div class="fieldcontain ${hasErrors(bean: dailyActivityInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="dailyActivity.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="endDate" precision="day"  value="${dailyActivityInstance?.endDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: dailyActivityInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="dailyActivity.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" precision="day"  value="${dailyActivityInstance?.startDate}"  />
</div>

<div class="fieldcontain ${hasErrors(bean: dailyActivityInstance, field: 'team', 'error')} required">
	<label for="team">
		<g:message code="dailyActivity.team.label" default="Team" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="team" name="team.id" from="${com.conditioncoach.Team.list()}" optionKey="id" required="" value="${dailyActivityInstance?.team?.id}" class="many-to-one"/>
</div>

