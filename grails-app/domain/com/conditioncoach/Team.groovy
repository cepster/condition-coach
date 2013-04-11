package com.conditioncoach

class Team {
	
	static hasMany = [teamMembers: TeamMember, dailyActivities: DailyActivity]
	
	/*
	 * Attributes
	 */
	String name;
	
    static constraints = {
    }
}
