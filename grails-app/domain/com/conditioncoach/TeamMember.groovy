package com.conditioncoach

import java.sql.Blob;

import com.conditioncoach.usersec.User

class TeamMember {
	
	static final INVITATION_SENT = 1
	static final ISMEMBER = 2
	static final INACTIVE = 3
	
	static hasOne = [user: User, team: Team]
	
	String lastName
	String firstName
	Date birthDate
	String email
	int status
	String nikeUserName
	String nikePassword
	User user
	Team team
	Blob avatar
	String avatarType
	
    static constraints = {
		birthDate nullable:true
		user nullable:true
		nikeUserName nullable:true
		nikePassword nullable:true
		avatar nullable: true, maxSize:1073741824, sqlType: "longblob"
		avatarType nullable: true
    }
	
	static mapping = {
		avatar type:"blob"
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
