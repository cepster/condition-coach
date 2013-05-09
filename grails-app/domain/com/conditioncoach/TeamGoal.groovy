package com.conditioncoach

import java.text.SimpleDateFormat

class TeamGoal {
	
	Date goalDate
	String goalDescription
	GoalMaster goalMaster

    static constraints = {
		goalMaster nullable:true
    }
	
	def getGoalDateFormatted(){
		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy")
		return formatter.format(goalDate)
	}
}
