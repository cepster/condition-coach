package com.conditioncoach.usersec

class Role {
	
	private static String ROLE_TEAMMEMBER = "ROLE_TEAMMEMBER"
	private static String ROLE_COACH = "ROLE_COACH"

	String authority

	static mapping = {
		cache true
	}

	static constraints = {
		authority blank: false, unique: true
	}
}
