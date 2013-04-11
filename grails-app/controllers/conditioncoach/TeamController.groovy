package conditioncoach

import grails.plugins.springsecurity.Secured

import com.conditioncoach.Team

class TeamController {
	
	static scaffold = Team

	@Secured(['ROLE_COACH'])
    def index() { 
		log.debug "CONTROLLER: Team, ACTION: List - REDIRECT TO List"
		redirect(action:"list", params:params);
	}
	
	@Secured(['ROLE_COACH'])
	def list(){
		log.debug "CONTROLLER: Team, ACTION: List"
		//params automatically comes in with HTTP params
		params.max = Math.min(params.max? params.int('max') : 10, 100);
		def teamList = Team.list(params);
		def teamCount = Team.count();
		
		//This is a groovy map literal.  I can put anything in to the map that needs to be referenced by the View
		[teamInstanceList: teamList, teamInstanceTotal: teamCount]
	}
	
	@Secured(['ROLE_COACH'])
	def create(){
		log.debug "CONTROLLER: Team, ACTION: Create"
		[teamInstance: new Team(params)]
	}
	
	@Secured(['ROLE_COACH'])
	def edit(){
		log.debug "CONTROLLER: Team, ACTION: Edit"
		def idToEdit = params.get("id");
		log.debug "--------- getting team id: " + idToEdit;
	}
}
