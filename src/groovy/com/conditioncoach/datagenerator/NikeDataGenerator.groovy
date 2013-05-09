package com.conditioncoach.datagenerator

import com.conditioncoach.TeamMember
import com.conditioncoach.TeamMemberData

class NikeDataGenerator {
	
	def random
	private static final int MIN_CALORIES = 800
	private static final int MAX_CALORIES = 3500
	private static final double MIN_HOURS_SLEPT = 0
	private static final double MAX_HOURS_SLEPT = 12

	def generate(int memberID){
		TeamMember member = TeamMember.get(memberID)
		generate(member)
	}
	
	def generate(TeamMember member){
		def range = 0..100
		range.each{it ->
			TeamMemberData data = new TeamMemberData()
			data.setMember(member)
			data.setDay(new Date() - it)
			data.setHoursSlept(getRandomHoursSlept())
			data.setCaloriesBurned(getRandomCaloriesBurned())
			data.save(flush:true)
		}
	}
	
	def getRandomCaloriesBurned(){
		return MIN_CALORIES + (int)(Math.random() * ((MAX_CALORIES - MIN_CALORIES) + 1))
	}
	
	def getRandomHoursSlept(){
		return MIN_HOURS_SLEPT + (Math.random() * ((MAX_HOURS_SLEPT - MIN_HOURS_SLEPT) + 1))
	}

}
