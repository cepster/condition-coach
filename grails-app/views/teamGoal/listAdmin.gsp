<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<title>Edit Team Goals</title>
</head>
<body>
  <div class="body">
  	<g:form method="post" >
		<g:hiddenField name="id" value="${goalMaster?.id}" />
		<g:hiddenField name="version" value="${goalMaster?.version}" />
		<g:hiddenField name="teamID" value="${goalMaster?.team?.id}" />
		<h1>Edit Team Goals</h1><br/>
		<fieldset class="form">
			<g:render template="form"/>
		</fieldset>
		<fieldset class="buttons">
			<g:actionSubmit class="save" action="save" value="Save" />
			<input type="button" class="edit" onClick="$('#addGoalDiv').dialog('open');" value="New Goal"/>
		</fieldset>
	</g:form>
  </div>
</body>
</html>