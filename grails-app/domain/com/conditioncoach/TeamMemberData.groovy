package com.conditioncoach

class TeamMemberData {
	
	TeamMember member
	Date day
	int caloriesBurned
	double hoursSlept

    static constraints = {
    }
	
	static namedQueries = {
		specificDay{ day ->
			gt 'day', day-1
			lt 'day', day+1
		}
		oneWeek{
			def now = new Date()
			gt 'day', now-7	
		}
		
		twoWeeks{
			def now = new Date()
			gt 'day', now-14
			
		}
		
		oneMonth{
			def now = new Date()
			gt 'day', now-30
		}
	}
	
	public def getDayYear(){
		Calendar cal = Calendar.getInstance()
		cal.setTime(day)
		return cal.get(Calendar.YEAR)
	}
	
	public def getDayMonth(){
		Calendar cal = Calendar.getInstance()
		cal.setTime(day)
		return cal.get(Calendar.MONTH)
	}
	
	def getDayDay(){
		Calendar cal = Calendar.getInstance()
		cal.setTime(day)
		return cal.get(Calendar.DAY_OF_MONTH)
	}
	
	def getTeamAverageCalories(){
		def results = TeamMemberData.specificDay(day).list()
		return results.sum{it.caloriesBurned}/results.size()
	}
	
	def getTeamCaloriesGoal(){
		GoalMaster goalMaster = GoalMaster.findByTeam(member.team)
		
		return goalMaster?.maxCalories? goalMaster?.maxCalories : 0
	}
	
	def getTeamAverageHoursSlept(numDays){
		def results = TeamMemberData.specificDay(day).list()
		return results.sum{it.hoursSlept}/results.size()
	}
	
	def getTeamHoursSleptGoal(){
		GoalMaster goalMaster = GoalMaster.findByTeam(member.team)
		return goalMaster?.minHoursSlept? goalMaster?.minHoursSlept : 0
	}
}
