package com.conditioncoach



import org.junit.*
import grails.test.mixin.*

@TestFor(TeamMemberDataController)
@Mock(TeamMemberData)
class TeamMemberDataControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/teamMemberData/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.teamMemberDataInstanceList.size() == 0
        assert model.teamMemberDataInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.teamMemberDataInstance != null
    }

    void testSave() {
        controller.save()

        assert model.teamMemberDataInstance != null
        assert view == '/teamMemberData/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/teamMemberData/show/1'
        assert controller.flash.message != null
        assert TeamMemberData.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/teamMemberData/list'

        populateValidParams(params)
        def teamMemberData = new TeamMemberData(params)

        assert teamMemberData.save() != null

        params.id = teamMemberData.id

        def model = controller.show()

        assert model.teamMemberDataInstance == teamMemberData
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/teamMemberData/list'

        populateValidParams(params)
        def teamMemberData = new TeamMemberData(params)

        assert teamMemberData.save() != null

        params.id = teamMemberData.id

        def model = controller.edit()

        assert model.teamMemberDataInstance == teamMemberData
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/teamMemberData/list'

        response.reset()

        populateValidParams(params)
        def teamMemberData = new TeamMemberData(params)

        assert teamMemberData.save() != null

        // test invalid parameters in update
        params.id = teamMemberData.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/teamMemberData/edit"
        assert model.teamMemberDataInstance != null

        teamMemberData.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/teamMemberData/show/$teamMemberData.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        teamMemberData.clearErrors()

        populateValidParams(params)
        params.id = teamMemberData.id
        params.version = -1
        controller.update()

        assert view == "/teamMemberData/edit"
        assert model.teamMemberDataInstance != null
        assert model.teamMemberDataInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/teamMemberData/list'

        response.reset()

        populateValidParams(params)
        def teamMemberData = new TeamMemberData(params)

        assert teamMemberData.save() != null
        assert TeamMemberData.count() == 1

        params.id = teamMemberData.id

        controller.delete()

        assert TeamMemberData.count() == 0
        assert TeamMemberData.get(teamMemberData.id) == null
        assert response.redirectedUrl == '/teamMemberData/list'
    }
}
