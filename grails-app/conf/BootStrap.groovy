import com.conditioncoach.Team
import com.conditioncoach.TeamMember
import com.conditioncoach.TeamMemberData
import com.conditioncoach.datagenerator.NikeDataGenerator
import com.conditioncoach.usersec.Role
import com.conditioncoach.usersec.User
import com.conditioncoach.usersec.UserRole

class BootStrap {

    def init = { servletContext ->

      def coachRole = new Role(authority: 'ROLE_COACH').save(flush: true)
      def teamMemberRole = new Role(authority: 'ROLE_TEAMMEMBER').save(flush: true)

      def testUser = new User(username: 'vikingsCoach', enabled: true, password: 'password')
      testUser.save(flush: true)
	  
	  def testUserRole = new UserRole(user:testUser, role: coachRole)
	  testUserRole.save(flush:true)
	  
	  def team = new Team(name: 'Vikings', user: testUser)
	  team.save(flush:true)
	  
	  def teamMemberUser = new User(username: 'mr@gmail.com', enabled: true, password: 'mr@gmail.com')
	  teamMemberUser.save(flush:true)
	  
	  def teamMemberUserRole = new UserRole(user:teamMemberUser, role:teamMemberRole)
	  teamMemberUserRole.save(flush:true)
	  
	  def teamMember = new TeamMember(email: 'mr@gmail.com', firstName: 'Matt', lastName: 'Richards', status:1, team: team, user: teamMemberUser)
	  teamMember.save(flush:true)
	  
	  NikeDataGenerator generator = new NikeDataGenerator()
	  generator.generate(teamMember)
	  
   }
    def destroy = {
    }
}
