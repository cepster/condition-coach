package conditioncoach

import com.conditioncoach.Team


class TeamController {

    def index() { 
		log.debug "CONTROLLER: Team, ACTION: List - REDIRECT TO List"
		redirect(action:"list", params:params);
	}
	
	def list(){
		log.debug "CONTROLLER: Team, ACTION: List"
		//params automatically comes in with HTTP params
		params.max = Math.min(params.max? params.int('max') : 10, 100);
		def teamList = Team.list(params);
		def teamCount = Team.count();
		
		//This is a groovy map literal.  I can put anything in to the map that needs to be referenced by the View
		[teamInstanceList: teamList, teamInstanceTotal: teamCount]
	}
	
	def create(){
		log.debug "CONTROLLER: Team, ACTION: Create"
		[teamInstance: new Team(params)]
	}
}
