package conditioncoach

import grails.converters.JSON
import grails.plugins.springsecurity.Secured

import javax.sql.rowset.serial.SerialBlob

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

import com.conditioncoach.Team
import com.conditioncoach.TeamMember
import com.conditioncoach.datagenerator.NikeDataGenerator
import com.conditioncoach.usersec.Role
import com.conditioncoach.usersec.User
import com.conditioncoach.usersec.UserRole

class TeamController {
	
	static scaffold = Team
	
	def springSecurityService

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
	def edit(Long id){
		log.debug "CONTROLLER: Team, ACTION: Edit"
		def idToEdit = params.get("id");
		log.debug "--------- getting team id: " + idToEdit;
		
		def teamInstance = Team.get(id)
		
		if(id == null){
			def thisUser = User.get(springSecurityService.getPrincipal().id)
			teamInstance = Team.findByUser(thisUser)
		}
		
		if (!teamInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'team.label', default: 'Team'), id])
			redirect(action: "list")
			return
		}

		[teamInstance: teamInstance]
	}
	
	@Secured(['ROLE_COACH'])
	def addTeamMember(){
		println "Team-addTeamMember HIT"
		params.each {key, value -> println "Key: ${key}, Value: ${value}" }

		User user = new User()
		user.setUsername(params.get("email"))
		user.setPassword(params.get("email"))
		user.setPasswordExpired(false)
		user.setEnabled(true)
		user.save(flush:true)
		
		UserRole role = new UserRole()
		role.setUser(user)
		role.setRole(Role.findByAuthority("ROLE_TEAMMEMBER"))
		role.save(flush:true)
				
		TeamMember m = new TeamMember()
		m.setFirstName(params.get("firstName"))
		m.setLastName(params.get("lastName"))
		m.setEmail(params.get("email"))
		m.setTeam(Team.get(params.get("teamID")))
		m.setStatus(TeamMember.INVITATION_SENT)
		m.setUser(user)
		m.save(flush:true)
		
		new NikeDataGenerator().generate(m)
		
		render m as JSON
	}
	
	@Secured(['ROLE_COACH'])
	def removeTeamMember(){
		println "Team-removeTeamMember HIT"
		
		params.each{key, value -> println "Key: ${key}, Value: ${value}"}
		
		def memberID = params.get("memberID")
		
		TeamMember member = TeamMember.get(memberID)
		member.delete()
	}
	
	def getSidebarData(Long id){
		def teamInstance
		
		if(id == null){
			def thisUser = User.get(springSecurityService.getPrincipal().id)
			println "Logged In User ${thisUser.id}"
			teamInstance = Team.findByUser(thisUser)
		}
		else{
			teamInstance = Team.get(id)
		}
		
		def dataMap = [name:teamInstance.name, avatar:teamInstance.avatar]
		render dataMap as JSON
	}
	
	static getTeamList(){
		
	}
	
	def save(){
		println "TeamController-save CALLED"
		
		def userInstance = User.get(springSecurityService.getPrincipal().id)
		def teamInstance = Team.findByUser(userInstance)
		
		if (!teamInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'team.label', default: 'Team'), id])
			redirect(action: "list")
			return
		}
		
		teamInstance.name = params.get("name")
		
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		MultipartFile originalFile = multiRequest.getFile("avatar");
		def stream = originalFile.getInputStream();
		
		def f = originalFile.getBytes()

		teamInstance.avatar =  new SerialBlob(f);
		teamInstance.avatarType = f = originalFile.getContentType()
		
		teamInstance.save(flush:true, failOnError:true)
		
		flash.message = message(code: 'default.updated.message', args: [message(code: 'team.label', default: 'Team'), teamInstance.id])
		redirect(action: "edit", id: teamInstance.id)
	}
	
	def displayAvatar = {
		
		def userInstance = User.get(springSecurityService.getPrincipal().id)
		def teamInstance = Team.findByUser(userInstance)
		
		response.contentType = "image/jpeg"
		
		def length = teamInstance?.avatar?.length()
		def byteArray = teamInstance?.avatar?.getBytes(Long.valueOf(1),Integer.valueOf(String.valueOf(length)))
		
		response.contentLength = length
		response.outputStream.write(byteArray)
	}
}
