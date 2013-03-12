import com.conditioncoach.usersec.Role;
import com.conditioncoach.usersec.User;
import com.conditioncoach.usersec.UserRole;

class BootStrap {

    def init = { servletContext ->

      def coachRole = new Role(authority: 'ROLE_COACH').save(flush: true)
      def teamMemberRole = new Role(authority: 'ROLE_TEAMMEMBER').save(flush: true)

      def testUser = new User(username: 'me', enabled: true, password: 'password')
      testUser.save(flush: true)

      UserRole.create testUser, coachRole, true

      assert User.count() == 1
      assert Role.count() == 2
      assert UserRole.count() == 1
   }
    def destroy = {
    }
}
