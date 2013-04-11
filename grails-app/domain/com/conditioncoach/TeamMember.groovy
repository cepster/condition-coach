package com.conditioncoach

import com.conditioncoach.usersec.User

class TeamMember {
	
	static final INVITATION_SENT = 1
	static final ISMEMBER = 2
	static final INACTIVE = 3
	
	static hasOne = [user: User, team: Team]
	
	String lastName
	String firstName
	Date birthDate
	int status
	User user
	Team team
	
    static constraints = {
    }
	
	String getStatusName(){
		if(status == INVITATION_SENT){
			"Invitation Sent"
		}
		else if(status == ISMEMBER){
			"Active"
		}
		else{
			"Inactive"
		}
	}
}
