package com.conditioncoach



import org.junit.*
import grails.test.mixin.*

@TestFor(TeamMemberController)
@Mock(TeamMember)
class TeamMemberControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/teamMember/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.teamMemberInstanceList.size() == 0
        assert model.teamMemberInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.teamMemberInstance != null
    }

    void testSave() {
        controller.save()

        assert model.teamMemberInstance != null
        assert view == '/teamMember/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/teamMember/show/1'
        assert controller.flash.message != null
        assert TeamMember.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/teamMember/list'

        populateValidParams(params)
        def teamMember = new TeamMember(params)

        assert teamMember.save() != null

        params.id = teamMember.id

        def model = controller.show()

        assert model.teamMemberInstance == teamMember
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/teamMember/list'

        populateValidParams(params)
        def teamMember = new TeamMember(params)

        assert teamMember.save() != null

        params.id = teamMember.id

        def model = controller.edit()

        assert model.teamMemberInstance == teamMember
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/teamMember/list'

        response.reset()

        populateValidParams(params)
        def teamMember = new TeamMember(params)

        assert teamMember.save() != null

        // test invalid parameters in update
        params.id = teamMember.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/teamMember/edit"
        assert model.teamMemberInstance != null

        teamMember.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/teamMember/show/$teamMember.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        teamMember.clearErrors()

        populateValidParams(params)
        params.id = teamMember.id
        params.version = -1
        controller.update()

        assert view == "/teamMember/edit"
        assert model.teamMemberInstance != null
        assert model.teamMemberInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/teamMember/list'

        response.reset()

        populateValidParams(params)
        def teamMember = new TeamMember(params)

        assert teamMember.save() != null
        assert TeamMember.count() == 1

        params.id = teamMember.id

        controller.delete()

        assert TeamMember.count() == 0
        assert TeamMember.get(teamMember.id) == null
        assert response.redirectedUrl == '/teamMember/list'
    }
}
