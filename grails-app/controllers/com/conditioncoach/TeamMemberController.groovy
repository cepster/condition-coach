package com.conditioncoach

import grails.converters.JSON

import java.sql.Blob
import java.text.SimpleDateFormat

import javax.sql.rowset.serial.SerialBlob

import org.springframework.dao.DataIntegrityViolationException
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

import com.conditioncoach.datagenerator.NikeDataGenerator
import com.conditioncoach.usersec.User

class TeamMemberController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [teamMemberInstanceList: TeamMember.list(params), teamMemberInstanceTotal: TeamMember.count()]
    }

    def create() {
        [teamMemberInstance: new TeamMember(params)]
    }
	
	def getSidebarData(Long id){
		def teamMemberInstance
		
		if(id == null){
			def thisUser = User.get(springSecurityService.getPrincipal().id)
			println "Logged In User ${thisUser.id}"
			teamMemberInstance = TeamMember.findByUser(thisUser)
		}
		else{
			teamMemberInstance = TeamMember.get(id)
		}
		
		def dataMap = [name:"${teamMemberInstance.firstName} ${teamMemberInstance.lastName}", avatar: teamMemberInstance.avatar]
		render dataMap as JSON
	}

    def save() {
		
		println "TeamMemberController-save CALLED"
		
		def userInstance = User.get(springSecurityService.getPrincipal().id)
		def teamMemberInstance = TeamMember.findByUser(userInstance)
		
		if (!teamMemberInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'teamMember.label', default: 'TeamMember'), id])
			redirect(action: "list")
			return
		}

		teamMemberInstance.firstName = params.get("firstName")
		teamMemberInstance.lastName = params.get("lastName")
		teamMemberInstance.nikePassword = params.get("nikePassword")
		teamMemberInstance.nikeUserName = params.get("nikeUsername")
		
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		MultipartFile originalFile = multiRequest.getFile("avatar");
		def stream = originalFile.getInputStream();
		
		def f = originalFile.getBytes()

		teamMemberInstance.avatar =  new SerialBlob(f);
		teamMemberInstance.avatarType = f = originalFile.getContentType()
		println "AVATAR: ${teamMemberInstance.avatar}"
		
		teamMemberInstance.save(flush:true, failOnError:true)
		
//        if (!teamMemberInstance.save(flush: true)) {
//			println "THERE WAS AN ERROR"
//            render(view: "create", model: [teamMemberInstance: teamMemberInstance])
//            return
//        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'teamMember.label', default: 'TeamMember'), teamMemberInstance.id])
        redirect(action: "edit", id: teamMemberInstance.id)
    }

    def show(Long id) {
        def teamMemberInstance = TeamMember.get(id)
        if (!teamMemberInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teamMember.label', default: 'TeamMember'), id])
            redirect(action: "list")
            return
        }

        [teamMemberInstance: teamMemberInstance]
    }

    def edit(Long id) {
		
		def teamMemberInstance
		
		if(id == null || id == 0){
			def userInstance = User.get(springSecurityService.getPrincipal().id)
			teamMemberInstance = TeamMember.findByUser(userInstance)
		}
		else{
			teamMemberInstance = TeamMember.get(id)
		}
        if (!teamMemberInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teamMember.label', default: 'TeamMember'), id])
            redirect(action: "list")
            return
        }

        [teamMemberInstance: teamMemberInstance]
    }
	
	def updateAvatar(Long id){
		def teamMemberInstance = TeamMember.get(id)
		
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request
		MultipartFile originalFile = multiRequest.getFile("avatar")
		
		def f = originalFile.getBytes()
		teamMemberInstance.avatar = new SerialBlob(f)
		
		teamMemberInstance.save(flush:true)
	}
	
	def changePassword(){
		
		params.each{key,value-> "${key}:${value}"}
		
		println "TEAMMEMBER-CHANGEPASSWORD"
		def userInstance = User.get(springSecurityService.getPrincipal().id)
		println "Changing password for user: ${userInstance.id}"
		userInstance.setPassword(params.get("newPassword"))
		userInstance.save(flush:true, failOnError:true)
	}

    def update(Long id, Long version) {
		
		println "TeamMemberController-update CALLED for id ${id}"
		
		def teamMemberInstance
		
		if(id == null || id == 0){
			def userInstance = User.get(springSecurityService.getPrincipal().id)
			teamMemberInstance = TeamMember.findByUser(userInstance)
		}
		else{
			teamMemberInstance = TeamMember.get(id)
		}
		
        if (!teamMemberInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teamMember.label', default: 'TeamMember'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (teamMemberInstance.version > version) {
                teamMemberInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'teamMember.label', default: 'TeamMember')] as Object[],
                          "Another user has updated this TeamMember while you were editing")
                render(view: "edit", model: [teamMemberInstance: teamMemberInstance])
                return
            }
        }

        teamMemberInstance.properties = params
		
		/*
		 * BirthDate
		 */
//		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy")
//		Date birthDate = formatter.parse(params.get("birthDate"))
//		println "BIRTHDATE: ${birthDate}"
//		teamMemberInstance.setBirthDate(birthDate as Date)
		
		/*
		 * Avatar
		 */
		MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
		MultipartFile originalFile = multiRequest.getFile("avatar");
		def stream = originalFile.getInputStream();
		def f = originalFile.getBytes()
		teamMemberInstance.avatar =  new SerialBlob(f);
		println "AVATAR: ${teamMemberInstance.avatar}"

        if (!teamMemberInstance.save(flush: true, failOnError:true)) {
			println "An error occurred"
            render(view: "edit", model: [teamMemberInstance: teamMemberInstance])
            return
        }
		
		NikeDataGenerator generator = new NikeDataGenerator()
		generator.generate(teamMemberInstance.id)

        flash.message = message(code: 'default.updated.message', args: [message(code: 'teamMember.label', default: 'TeamMember'), teamMemberInstance.id])
        redirect(action: "show", id: teamMemberInstance.id)
    }
	
	def checkPWValidity(){
		def inputPW = springSecurityService.encodePassword(params.get("password"))
		
		def userInstance = User.get(springSecurityService.getPrincipal().id)
		
		def map = new HashMap()
		
		if(inputPW.equals(userInstance.getPassword())){
			render map.valid = true
		}
		else{
			render map.valid = false
		}
		
		render map as JSON
	}

    def delete(Long id) {
        def teamMemberInstance = TeamMember.get(id)
        if (!teamMemberInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teamMember.label', default: 'TeamMember'), id])
            redirect(action: "list")
            return
        }

        try {
            teamMemberInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'teamMember.label', default: 'TeamMember'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'teamMember.label', default: 'TeamMember'), id])
            redirect(action: "show", id: id)
        }
    }
	
	def displayAvatar = {
		
		def userInstance = User.get(springSecurityService.getPrincipal().id)
		def teamMember = TeamMember.findByUser(userInstance)
		
		response.contentType = "image/jpeg"
		
		def length = teamMember?.avatar?.length()
		def byteArray = teamMember?.avatar?.getBytes(Long.valueOf(1),Integer.valueOf(String.valueOf(length)))
		
		response.contentLength = length
		response.outputStream.write(byteArray)
	}
}
