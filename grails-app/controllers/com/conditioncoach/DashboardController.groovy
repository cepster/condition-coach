package com.conditioncoach

import grails.converters.JSON
import grails.plugins.springsecurity.Secured

import com.conditioncoach.GoalMaster
import com.conditioncoach.TeamMember
import com.conditioncoach.TeamMemberData
import com.conditioncoach.usersec.User

class DashboardController {
	
	def springSecurityService

	@Secured(['ROLE_TEAMMEMBER'])
    def index() { 
		def thisUser = User.get(springSecurityService.getPrincipal().id)
		def teamMember = TeamMember.findByUser(thisUser)
		def dataList = TeamMemberData.oneWeek.findAllWhere(member:teamMember)
		
		def dailyActivityList = DailyActivityController.getData(params)
		
		[data:dataList, dailyActivityInstanceList:dailyActivityList]
	}
	
	def getDataAJAX() {
		def thisUser = User.get(springSecurityService.getPrincipal().id)
		def teamMember = TeamMember.findByUser(thisUser)
		
		def days = params.get("days") as Integer
		
		def dataList
		if(days == 7){
			dataList = TeamMemberData.oneWeek.findAllWhere(member:teamMember)	
		}
		else if (days == 14){
			dataList = TeamMemberData.twoWeeks.findAllWhere(member:teamMember)
		}
		else{
			dataList = TeamMemberData.oneMonth.findAllWhere(member:teamMember)
		}
		
		GoalMaster goal = GoalMaster.findByTeam(teamMember.team)
		
		println dataList as JSON
		def returnList = new ArrayList()
		
		dataList.each{it ->
			def item = new HashMap()
			item.year = it.getDayYear()
			item.month = it.getDayMonth()
			item.day = it.getDayDay()
			item.caloriesBurned = it.caloriesBurned
			item.teamAverageCalories = it.getTeamAverageCalories()
			item.calorieGoal = goal?.maxCalories
			item.hoursSlept = it.hoursSlept
			item.teamAverageHoursSlept = it.getTeamAverageHoursSlept(days)
			item.hoursSleptGoal = goal?.minHoursSlept
			returnList.add(item)
		}
		
		render returnList as JSON
	}
}
