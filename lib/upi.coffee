{CompositeDisposable} = require 'atom'
{MainMenuLabel, getEventType} = require './utils'

module.exports =
class UPI
  constructor: (@pluginManager) ->
    @disposables = new CompositeDisposable

  setMenu: (name, menu) ->
    @disposables.add menuDisp = atom.menu.add [
      label: MainMenuLabel
      submenu: [ label: name, submenu: menu ]
    ]
    menuDisp

  setStatus: (status) ->
    @pluginManager.outputView.backendStatus status

  addMessages: (messages, types) ->
    @pluginManager.checkResults.appendResults messages, types

  setMessages: (messages, types) ->
    @pluginManager.checkResults.setResults messages, types

  clearMessages: (types) ->
    @pluginManager.checkResults.setResults [], types

  setMessageTypes: (types) ->
    for type, opts of types
      @pluginManager.outputView.createTab type, opts

  onShouldShowTooltip: (callback) ->
    @disposables.add disp = @pluginManager.onShouldShowTooltip ({editor, pos, eventType}) =>
      @showTooltip
        editor: editor
        pos: pos
        eventType: eventType
        tooltip: (crange) -> callback editor, crange
    disp

  showTooltip: ({editor, pos, eventType, detail, tooltip}) ->
    controller = @pluginManager.controller(editor)
    @withEventRange {controller, pos, detail, eventType}, ({crange, pos}) =>
      tooltip(crange).then ({range, text}) ->
        controller.showTooltip pos, range, text, eventType
      .catch (status = {status: 'warning'}) =>
        if status.status?
          controller.hideTooltip eventType
          @setStatus status

  onWillSaveBuffer: (callback) ->
    @pluginManager.onWillSaveBuffer callback

  onDidSaveBuffer: (callback) ->
    @pluginManager.onDidSaveBuffer callback

  addPanelControl: (element, opts) ->
    @pluginManager.outputView.addPanelControl element, opts

  withEventRange: ({editor, detail, eventType, pos, controller}, callback) ->
    eventType ?= getEventType detail
    controller ?= @pluginManager.controller(editor)
    return unless controller?

    callback (controller.getEventRange pos, eventType)