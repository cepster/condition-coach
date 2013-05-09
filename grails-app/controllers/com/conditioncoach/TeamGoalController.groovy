package com.conditioncoach

import grails.converters.JSON
import java.text.SimpleDateFormat

import com.conditioncoach.usersec.User

class TeamGoalController {

	def springSecurityService

    def index() {
        redirect(action: "list", params: params)
    }

    def listAdmin() {
		def thisUser = User.get(springSecurityService.getPrincipal().id)
		def team = Team.findByUser(thisUser)
		
		def goalMaster = GoalMaster.findByTeam(team)
		def teamGoalList
		
		if(goalMaster == null){
			goalMaster = new GoalMaster()
		}
		else{
			teamGoalList = TeamGoal.findAllByGoalMaster(goalMaster)
		}
		
		[goalMaster:goalMaster, teamGoalList:teamGoalList]
    }
	
	def getGoalsByMember(){
		def thisUser = User.get(springSecurityService.getPrincipal().id)
		def teamMember = TeamMember.findByUser(thisUser)

		def goalMaster = GoalMaster.findByTeam(teamMember.team)
		def teamGoalList
		
		if(goalMaster == null){
			teamGoalList = new ArrayList()
		}		
		else{
			teamGoalList = TeamGoal.findAllByGoalMaster(goalMaster)
		}
		
		println (teamGoalList as JSON)
		render teamGoalList as JSON
	}
	
	def save(Long id){
		
		GoalMaster goalMaster = GoalMaster.get(id)
		def team
		if(goalMaster == null){
			goalMaster = new GoalMaster()
			def thisUser = User.get(springSecurityService.getPrincipal().id)
			team = Team.findByUser(thisUser)
		}
		else{
			team = goalMaster.team
		}
		goalMaster.setMinCalories(Integer.valueOf(params.get("minCalories")))
		goalMaster.setMaxCalories(Integer.valueOf(params.get("maxCalories")))
		goalMaster.setMinHoursSlept(Double.valueOf(params.get("minHoursSlept")))
		goalMaster.setMaxHoursSlept(Double.valueOf(params.get("maxHoursSlept")))
		goalMaster.setTeam(team)
		goalMaster.save(flush:true)
		
		params.each {key,value->
			if(String.valueOf(key).startsWith("teamGoalID")){
				def index = String.valueOf(key).substring(10)
				println "Index is ${index}"
				def goalID = params.get("teamGoalID" + index)
				
				SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy")
				def goalDateParam = params.get("goalDate" + index)
				Date goalDate = formatter.parse(params.get("goalDate" + index))
				
				def goalDescription = params.get("goalDescription" + index)
				
				TeamGoal teamGoal = TeamGoal.get(goalID)
				if(teamGoal == null){
					teamGoal = new TeamGoal()
				}
				teamGoal.goalMaster = goalMaster
				teamGoal.goalDate = goalDate
				teamGoal.goalDescription = goalDescription
				
				println "GoalID: ${teamGoal.id}, masterID: ${goalMaster.id}, date: ${teamGoal.goalDate}, description: ${teamGoal.goalDescription}"
				
				teamGoal.save(flush:true)
			}
		}
		
		redirect(action:'listAdmin')
	}
}
