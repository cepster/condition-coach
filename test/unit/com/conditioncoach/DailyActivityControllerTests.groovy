package com.conditioncoach



import org.junit.*
import grails.test.mixin.*

@TestFor(DailyActivityController)
@Mock(DailyActivity)
class DailyActivityControllerTests {

    def populateValidParams(params) {
        assert params != null
        // TODO: Populate valid properties like...
        //params["name"] = 'someValidName'
    }

    void testIndex() {
        controller.index()
        assert "/dailyActivity/list" == response.redirectedUrl
    }

    void testList() {

        def model = controller.list()

        assert model.dailyActivityInstanceList.size() == 0
        assert model.dailyActivityInstanceTotal == 0
    }

    void testCreate() {
        def model = controller.create()

        assert model.dailyActivityInstance != null
    }

    void testSave() {
        controller.save()

        assert model.dailyActivityInstance != null
        assert view == '/dailyActivity/create'

        response.reset()

        populateValidParams(params)
        controller.save()

        assert response.redirectedUrl == '/dailyActivity/show/1'
        assert controller.flash.message != null
        assert DailyActivity.count() == 1
    }

    void testShow() {
        controller.show()

        assert flash.message != null
        assert response.redirectedUrl == '/dailyActivity/list'

        populateValidParams(params)
        def dailyActivity = new DailyActivity(params)

        assert dailyActivity.save() != null

        params.id = dailyActivity.id

        def model = controller.show()

        assert model.dailyActivityInstance == dailyActivity
    }

    void testEdit() {
        controller.edit()

        assert flash.message != null
        assert response.redirectedUrl == '/dailyActivity/list'

        populateValidParams(params)
        def dailyActivity = new DailyActivity(params)

        assert dailyActivity.save() != null

        params.id = dailyActivity.id

        def model = controller.edit()

        assert model.dailyActivityInstance == dailyActivity
    }

    void testUpdate() {
        controller.update()

        assert flash.message != null
        assert response.redirectedUrl == '/dailyActivity/list'

        response.reset()

        populateValidParams(params)
        def dailyActivity = new DailyActivity(params)

        assert dailyActivity.save() != null

        // test invalid parameters in update
        params.id = dailyActivity.id
        //TODO: add invalid values to params object

        controller.update()

        assert view == "/dailyActivity/edit"
        assert model.dailyActivityInstance != null

        dailyActivity.clearErrors()

        populateValidParams(params)
        controller.update()

        assert response.redirectedUrl == "/dailyActivity/show/$dailyActivity.id"
        assert flash.message != null

        //test outdated version number
        response.reset()
        dailyActivity.clearErrors()

        populateValidParams(params)
        params.id = dailyActivity.id
        params.version = -1
        controller.update()

        assert view == "/dailyActivity/edit"
        assert model.dailyActivityInstance != null
        assert model.dailyActivityInstance.errors.getFieldError('version')
        assert flash.message != null
    }

    void testDelete() {
        controller.delete()
        assert flash.message != null
        assert response.redirectedUrl == '/dailyActivity/list'

        response.reset()

        populateValidParams(params)
        def dailyActivity = new DailyActivity(params)

        assert dailyActivity.save() != null
        assert DailyActivity.count() == 1

        params.id = dailyActivity.id

        controller.delete()

        assert DailyActivity.count() == 0
        assert DailyActivity.get(dailyActivity.id) == null
        assert response.redirectedUrl == '/dailyActivity/list'
    }
}
