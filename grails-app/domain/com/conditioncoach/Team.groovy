package com.conditioncoach

import java.sql.Blob

import com.conditioncoach.usersec.User

class Team {
	
	static hasMany = [teamMembers: TeamMember, dailyActivities: DailyActivity]
	static hasOne = [goalMaster: GoalMaster]
	
	/*
	 * Attributes
	 */
	String name
	User user
	Blob avatar
	String avatarType

	static constraints = {
//		user nullable:true
		goalMaster nullable:true
		avatar nullable: true, maxSize:1073741824, sqlType: "longblob"
		avatarType nullable: true
    }
	
	static mapping = {
		avatar type:"blob"
	}
}
