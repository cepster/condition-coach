package com.conditioncoach

class DailyActivity {

	Date startDate
	Date endDate
	String activityDescription
	Team team
	
    static constraints = {
		startDate nullable:true
		endDate nullable:true
    }
}
