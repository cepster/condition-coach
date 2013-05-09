<%@ page import="com.conditioncoach.Team" %>

<script type="text/javascript">

	var goalListSize = ${teamGoalList? teamGoalList?.size() : 0};

	$(document).ready(function(){
		$('#addGoalDiv').dialog({
			title: 'New Team Goal',
			autoOpen:false,
			height:500,
			width:500,
			show:'scale',
			hide:'scale',
			buttons: [
			{id:"submit",
			 text: "Submit",
			 click: function(){
					addGoal();
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

		$('#goalDate').datepicker();
		
	});

	function addGoal(){
		var goalDate = $('#goalDate').val();
		var goalDescription = $('#goalDescription').val();
		$('#teamGoalTable').append('<tr><td><input type="text" id="goalDate'  + goalListSize + '" name="goalDate' + goalListSize +'" value="' + goalDate + '"/></td>' + 
									   '<td><input type="text" id="goalDescription' + goalListSize + '" name="goalDescription' + goalListSize + '" value="' + goalDescription + '"/></td>' + 
									   '<td><input type="hidden" id="teamGoalID' + goalListSize +'" name="teamGoalID' + goalListSize + '"/>X</td></tr>');
		$('#addGoalDiv').dialog('close');
		$('#goalDate').val('');
		$('#goalDescription').val('');
		goalListSize++;
	}
	
</script>

<div class="required">
	<label for="minCalories">
		<g:message code="teamGoal.minCalories.label" default="Minimum Calories" />
	</label>
	<g:field name="minCalories" type="number" value="${goalMaster.minCalories? goalMaster?.minCalories: 2000}"/>
	<br/><br/>
</div>

<div class="required">
	<label for="maxCalories">
		<g:message code="teamGoal.maxCalories.label" default="Maximum Calories" />
	</label>
	<g:field name="maxCalories" type="number" value="${goalMaster.maxCalories? goalMaster?.maxCalories: 2000}"/>
	<br/><br/>
</div>

<div class="required">
	<label for="minHoursSlept">
		<g:message code="teamGoal.minHoursSlept.label" default="Minimum Hours Slept" />
	</label>
	<g:field name="minHoursSlept" type="number" value="${goalMaster.minHoursSlept? goalMaster?.minHoursSlept: 7}"/>
	<br/><br/>
</div>

<div class="required">
	<label for="maxHoursSlept">
		<g:message code="teamGoal.maxHoursSlept.label" default="Maximum Hours Slept" />
	</label>
	<g:field name="maxHoursSlept" type="number" value="${goalMaster.maxHoursSlept? goalMaster?.maxHoursSlept: 9}"/>
	<br/><br/>
</div>

<table id="teamGoalTable">
	<thead>
		<tr>
			<th>
				Goal Date
			</th>
			<th>
				Goal Description
			</th>
			<th>
				Delete
			</th>
		</tr>
	</thead>
	<tbody>
		<g:each in="${teamGoalList}" status="i" var="it">
			<tr>
				<td>
					<g:textField name="goalDate${i}" value="${it.getGoalDateFormatted()}"></g:textField>
				</td>
				<td>
					<g:textField name="goalDescription${i}" value="${it.goalDescription}"></g:textField>
				</td>
				<td>
					<input type="hidden" id="teamGoalID${i}" name="teamGoalID${i}"/>
					<a href="javascript('delete this');">X</a>
				</td>
			</tr>
		</g:each>
	</tbody>
</table>

<div id="addGoalDiv">
	<table>
		<tr>
			<td>Goal Date</td>
		</tr>
		<tr>
			<td><input id="goalDate" name="goalDate"></input>
		</tr>
		<tr>
			<td>Goal Description</td>
		</tr>
		<tr>
			<td><g:textArea name="goalDescription"></g:textArea>
		</tr>
	</table>
</div>




