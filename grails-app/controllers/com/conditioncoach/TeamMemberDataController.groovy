package com.conditioncoach

import org.springframework.dao.DataIntegrityViolationException

class TeamMemberDataController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def index() {
        redirect(action: "list", params: params)
    }

    def list(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        [teamMemberDataInstanceList: TeamMemberData.list(params), teamMemberDataInstanceTotal: TeamMemberData.count()]
    }

    def create() {
        [teamMemberDataInstance: new TeamMemberData(params)]
    }

    def save() {
        def teamMemberDataInstance = new TeamMemberData(params)
        if (!teamMemberDataInstance.save(flush: true)) {
            render(view: "create", model: [teamMemberDataInstance: teamMemberDataInstance])
            return
        }

        flash.message = message(code: 'default.created.message', args: [message(code: 'teamMemberData.label', default: 'TeamMemberData'), teamMemberDataInstance.id])
        redirect(action: "show", id: teamMemberDataInstance.id)
    }

    def show(Long id) {
        def teamMemberDataInstance = TeamMemberData.get(id)
        if (!teamMemberDataInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teamMemberData.label', default: 'TeamMemberData'), id])
            redirect(action: "list")
            return
        }

        [teamMemberDataInstance: teamMemberDataInstance]
    }

    def edit(Long id) {
        def teamMemberDataInstance = TeamMemberData.get(id)
        if (!teamMemberDataInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teamMemberData.label', default: 'TeamMemberData'), id])
            redirect(action: "list")
            return
        }

        [teamMemberDataInstance: teamMemberDataInstance]
    }

    def update(Long id, Long version) {
        def teamMemberDataInstance = TeamMemberData.get(id)
        if (!teamMemberDataInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teamMemberData.label', default: 'TeamMemberData'), id])
            redirect(action: "list")
            return
        }

        if (version != null) {
            if (teamMemberDataInstance.version > version) {
                teamMemberDataInstance.errors.rejectValue("version", "default.optimistic.locking.failure",
                          [message(code: 'teamMemberData.label', default: 'TeamMemberData')] as Object[],
                          "Another user has updated this TeamMemberData while you were editing")
                render(view: "edit", model: [teamMemberDataInstance: teamMemberDataInstance])
                return
            }
        }

        teamMemberDataInstance.properties = params

        if (!teamMemberDataInstance.save(flush: true)) {
            render(view: "edit", model: [teamMemberDataInstance: teamMemberDataInstance])
            return
        }

        flash.message = message(code: 'default.updated.message', args: [message(code: 'teamMemberData.label', default: 'TeamMemberData'), teamMemberDataInstance.id])
        redirect(action: "show", id: teamMemberDataInstance.id)
    }

    def delete(Long id) {
        def teamMemberDataInstance = TeamMemberData.get(id)
        if (!teamMemberDataInstance) {
            flash.message = message(code: 'default.not.found.message', args: [message(code: 'teamMemberData.label', default: 'TeamMemberData'), id])
            redirect(action: "list")
            return
        }

        try {
            teamMemberDataInstance.delete(flush: true)
            flash.message = message(code: 'default.deleted.message', args: [message(code: 'teamMemberData.label', default: 'TeamMemberData'), id])
            redirect(action: "list")
        }
        catch (DataIntegrityViolationException e) {
            flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'teamMemberData.label', default: 'TeamMemberData'), id])
            redirect(action: "show", id: id)
        }
    }
}
