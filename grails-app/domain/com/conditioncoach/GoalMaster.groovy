package com.conditioncoach

class GoalMaster {
	
	static hasMany = [teamGoals: TeamGoal]

	Team team
	int minCalories
	int maxCalories
	double minHoursSlept
	double maxHoursSlept

	static constraints = {
	}
}
