package com.conditioncoach

import grails.converters.JSON

import java.text.SimpleDateFormat
import java.util.Formatter.DateTime

import org.springframework.dao.DataIntegrityViolationException

import com.conditioncoach.usersec.User

class DailyActivityController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]
	
	def springSecurityService

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		
		def map = new HashMap()
		map.events = DailyActivity.list(params).collect{activity ->
			return [item: activity.activityDescription, start: activity.startDate, end: activity.endDate]
		}
		
        [dailyActivityInstanceList: getData(params), dailyActivityInstanceTotal: DailyActivity.count()]
    }
	
	static def getData(params){
		println "DailyActivityController-GETDATA"
		
		def map = DailyActivity.list(params).collect{activity ->
			Calendar c = Calendar.getInstance()
			c.setTime(activity.startDate)
			def startYear = c.get(Calendar.YEAR)
			def startMonth = c.get(Calendar.MONTH)
			if(Integer.valueOf(startMonth) < 10){
				startMonth = String.valueOf("0${startMonth}")
			}
			def startDay = c.get(Calendar.DAY_OF_MONTH)
			if(Integer.valueOf(startDay) < 10){
				startDay = String.valueOf("0${startDay}")
			}
			def startString = "${startYear}-${startMonth}-${startDay} 12:00:00"
			
			c.setTime(activity.endDate)
			def endYear = c.get(Calendar.YEAR)
			def endMonth = c.get(Calendar.MONTH)
			if(Integer.valueOf(endMonth) < 10){
				endMonth = String.valueOf("0${endMonth}")
			}
			def endDay = c.get(Calendar.DAY_OF_MONTH)
			if(Integer.valueOf(endDay) < 10){
				endDay = String.valueOf("0${endDay}")
			}
			def endString = "${endYear}-${endMonth}-${endDay} 12:00:00"
			
			
			return [id: activity.id, title: activity.activityDescription, startYear: startYear, startMonth: startMonth, startDay: startDay,
					endYear: endYear, endMonth: endMonth, endDay: endDay]
		}
		
		return map
	}

    def create() {
        [dailyActivityInstance: new DailyActivity(params)]
    }

    def save() {
		println "DailyActivityController-SAVE"
		
		params.each{key,value->println "${key}:${value}"}
		
		def thisUser = User.get(springSecurityService.getPrincipal().id)
		def team = Team.findByUser(thisUser)
		
		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy")
		Date startDate = formatter.parse(params.get("startDate"))
		Date endDate = formatter.parse(params.get("endDate"))
		
        def dailyActivityInstance = new DailyActivity()
		dailyActivityInstance.startDate = startDate
		dailyActivityInstance.endDate = endDate
		dailyActivityInstance.setActivityDescription(params.get("activityDescription"))
		dailyActivityInstance.setTeam(team)
		
        if (!dailyActivityInstance.save(flush: true, failOnError:true)) {
			println "Save Failed"
            render(view: "create", model: [dailyActivityInstance: dailyActivityInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'dailyActivity.label', default: 'DailyActivity'), dailyActivityInstance.id])
        redirect(action: "list", id: dailyActivityInstance.id)
    }

    def show(Long id) {
        def dailyActivityInstance = DailyActivity.get(id)
        if (!dailyActivityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dailyActivity.label', default: 'DailyActivity'), id])
            redirect(action: "list")
            return
        }

        [dailyActivityInstance: dailyActivityInstance]
    }

    def edit(Long id) {
        def dailyActivityInstance = DailyActivity.get(id)
        if (!dailyActivityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dailyActivity.label', default: 'DailyActivity'), id])
            redirect(action: "list")
            return
        }

        [dailyActivityInstance: dailyActivityInstance]
    }

    def update(Long id, Long version) {
        def dailyActivityInstance = DailyActivity.get(id)
        if (!dailyActivityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dailyActivity.label', default: 'DailyActivity'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (dailyActivityInstance.version > version) {
                dailyActivityInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'dailyActivity.label', default: 'DailyActivity')] as Object[],
                          "Another user has updated this DailyActivity while you were editing")
                render(view: "edit", model: [dailyActivityInstance: dailyActivityInstance])
                return
            }
        }

        dailyActivityInstance.properties = params

        if (!dailyActivityInstance.save(flush: true)) {
            render(view: "edit", model: [dailyActivityInstance: dailyActivityInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'dailyActivity.label', default: 'DailyActivity'), dailyActivityInstance.id])
        redirect(action: "show", id: dailyActivityInstance.id)
    }

    def delete(Long id) {
        def dailyActivityInstance = DailyActivity.get(id)
        if (!dailyActivityInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'dailyActivity.label', default: 'DailyActivity'), id])
            redirect(action: "list")
            return
        }

        try {
            dailyActivityInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'dailyActivity.label', default: 'DailyActivity'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'dailyActivity.label', default: 'DailyActivity'), id])
            redirect(action: "show", id: id)
        }
    }
}
