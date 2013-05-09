<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<title><g:layoutTitle default="Grails"/></title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
		<link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
		<link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">
		<link rel="stylesheet" href="${resource(dir: 'css', file: 'mobile.css')}" type="text/css">
		<g:layoutHead/>
		<g:javascript library='jquery' />
		<g:javascript library='jquery-ui' />
		<g:javascript library="application"/>
		<r:layoutResources />
		<style type="text/css">
		
			.profileLink{
				display:none;
				position:absolute;
				background-color:#C9C9C9;
				padding:2px;
				text-decoration:none;
				-moz-border-radius: 0px 5px 5px 0px;
				-webkit-border-radius: 0px 5px 5px 0px;
				border-radius: 0px 5px 5px 0px;
				color:#FFFFFF !important;
			}
			
			.profileLink:hover{
				background-color:white;
				color:black !important;
			}
		
			#profileName{
				top:25%;
			}
			
			#profileHome{
				top:35%;
			}
			
			#profileEditProfile{
				top:45%;
			}
			
		</style>
		<sec:ifAllGranted roles="ROLE_TEAMMEMBER">
			<script type="text/javascript">
				$(document).ready(function(){
					$.ajax('${createLink(controller:"TeamMember", action:"GetSidebarData")}')
						.done(function(data){
							$('.profileLink').show();
							$('#profileName').empty().html(eval(data).name);
							if(eval(data).avatar == null){
								$('#memberAvatar').hide();
							}
							else{
								$('#defaultMemberAvatar').hide();
							}
						})
						.fail(function(message){
							alert('error: ' + message);
						});

					$('#profileInfo').show('slow');
				});
			</script>
		</sec:ifAllGranted>
		<sec:ifAllGranted roles="ROLE_COACH">
			<script type="text/javascript">
				$(document).ready(function(){
					$.ajax('${createLink(controller:"Team", action:"GetSidebarData")}')
						.done(function(data){
							$('.profileLink').show();
							$('#profileName').empty().html(eval(data).name);
							if(eval(data).avatar == null){
								$('#teamAvatar').hide();
							}
							else{
								$('#defaultTeamAvatar').hide();	
							}
						})
						.fail(function(message){
							alert('error: ' + message);
						});

					$('#profileInfo').show('slow');
				});
			</script>
		</sec:ifAllGranted>
	</head>
	<body>
		<div id="headerStrip" role="banner" style="z-index:-1">
			<a href="${createLink(uri: '/')}" style="display:inline;font-size:32pt;left:0px;font-family:Impact, Charcoal, sans-serif">Condition Coach</a>
			<sec:ifLoggedIn>
				<g:link controller="logout" action="index" style="position:absolute;right:0px;">Log Out</g:link> 
			</sec:ifLoggedIn>
		</div>
		<div id="profileInfo" style="display:none;">
			<sec:ifAllGranted roles="ROLE_TEAMMEMBER">
				<img id="memberAvatar" src="${createLink(controller:'TeamMember', action:'displayAvatar', id:teamMemberInstance?.id)}" style="height:20%;width:80%;left:10%;top:2%;position:absolute;"/><br/>
				<img id="defaultMemberAvatar" src="${resource(dir: 'images', file: 'defaultAvatar.jpg')}" style="height:20%;width:80%;left:10%;top:2%;position:absolute;"/><br/>
				<g:link elementId="profileName" class="profileLink" controller="Dashboard" action="index"></g:link>
				<a href="${createLink(uri:'/')}" id="profileHome" class="profileLink">Home</a>
				<g:link elementId="profileEditProfile" controller="TeamMember" action="edit" class="profileLink">Edit Profile</g:link>
			</sec:ifAllGranted>
			<sec:ifAllGranted roles="ROLE_COACH">
					<img id="teamAvatar" src="${createLink(controller:'Team', action:'displayAvatar', id:teamMemberInstance?.team?.id)}" style="height:20%;width:80%;left:10%;top:2%;position:absolute;"/><br/>
					<img id="defaultTeamAvatar" src="${resource(dir:'images', file:'defaultAvatar.jpg')}" style="height:20%;width:80%;left:10%;top:2%;position:absolute;"/><br/>
				<g:link elementId="profileName" class="profileLink" controller="Team" action="edit" id="${teamMemberInstance?.team?.id}"></g:link>
				<a href="${createLink(uri:'/')}" id="profileHome" class="profileLink">Home</a>
			</sec:ifAllGranted>
		</div>
		<div id="contentPane">
			<g:layoutBody/>
		</div>
<%--		<div class="footer" role="contentinfo"></div>--%>
		<div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
		
		<r:layoutResources />
	</body>
</html>
