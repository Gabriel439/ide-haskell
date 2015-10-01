OutputPanelButtonsElement = require './output-panel-buttons'
OutputPanelItemsElement = require './output-panel-items'
ProgressBar = require './progress-bar'
SubAtom = require 'sub-atom'
{Disposable} = require 'atom'

module.exports=
class OutputPanelView extends HTMLElement
  setModel: (@model) ->
    @disposables.add @model.onStatusChanged (o) => @statusChanged o
    @disposables.add @model.onProgressChanged (o) => @setProgress o
    @disposables.add @model.onSetBuildTarget (o) =>
      @target.style.setProperty 'display', ''
      @target.innerText = o
    @disposables.add @model.results.onDidUpdate ({types}) =>
      if atom.config.get('ide-haskell.switchTabOnCheck')
        @activateFirstNonEmptyTab types
      @updateItems()
    @items.setModel @model.results

    @style.height = @model.state.height if @model.state?.height?
    @activateTab(@model.state.activeTab ? @buttons.buttonNames()[0])
    @buttons.setFileFilter @model.state.fileFilter

    @

  createdCallback: ->
    @disposables = new SubAtom
    @appendChild @resizeHandle = document.createElement 'resize-handle'
    @initResizeHandle()
    @appendChild @heading = document.createElement 'ide-haskell-panel-heading'
    @heading.appendChild @status = document.createElement 'ide-haskell-status-icon'
    @status.setAttribute 'data-status', 'ready'
    @heading.appendChild @buttons = new OutputPanelButtonsElement
    @heading.appendChild @target = document.createElement 'ide-haskell-target'
    @target.style.setProperty 'display', 'none'
    @disposables.add @target, 'click', ->
      atom.commands.dispatch atom.views.getView(atom.workspace),
        'ide-haskell:set-build-target'
    @heading.appendChild @cancelBtn = document.createElement 'ide-haskell-button'
    @cancelBtn.classList.add 'cancel'
    @cancelBtn.style.setProperty 'visibility', 'hidden'
    @heading.appendChild @progressBar = new ProgressBar
    @progressBar.setProgress 0
    @appendChild @items = new OutputPanelItemsElement
    @disposables.add @buttons.onButtonClicked =>
      @updateItems()
    @disposables.add @buttons.onCheckboxSwitched =>
      @updateItems()
    @disposables.add atom.workspace.onDidChangeActivePaneItem =>
      @updateItems() if @buttons.getFileFilter()

  disposeCancelBtnClicked: ->
    @cancelBtn.style.setProperty 'visibility', 'hidden'
    @cancelBtnClick?.dispose?()
    @cancelBtnClick = null

  detachedCallback: ->
    @disposables.dispose()
    @disposeCancelBtnClicked()

  initResizeHandle: ->
    @disposables.add @resizeHandle, 'mousedown', (e) =>
      startY = e.clientY
      startHeight = parseInt document.defaultView.getComputedStyle(@).height, 10

      doDrag = (e) =>
        @style.height = (startHeight - e.clientY + startY) + 'px'

      stopDrag = (e) ->
        document.documentElement.removeEventListener 'mousemove', doDrag
        document.documentElement.removeEventListener 'mouseup', stopDrag

      document.documentElement.addEventListener 'mousemove', doDrag
      document.documentElement.addEventListener 'mouseup', stopDrag

  updateItems: ->
    activeTab = @getActiveTab()
    filter = severity: activeTab
    if @buttons.getFileFilter()
      uri = atom.workspace.getActiveTextEditor()?.getPath?()
      filter.uri = uri if uri? and @buttons.options(activeTab).uriFilter
    scroll = @buttons.options(activeTab).autoScroll and @items.atEnd()
    @items.filter filter
    @items.scrollToEnd() if scroll

    for btn in @buttons.buttonNames()
      f = severity: btn
      f.uri = uri if uri? and @buttons.options(btn).uriFilter
      @buttons.setCount btn, @model.results.filter(f).length

  activateTab: (tab) ->
    @buttons.clickButton tab

  activateFirstNonEmptyTab: (types) ->
    for name in @buttons.buttonNames() when (if types? then name in types else true)
      if (@model.results.filter severity: name).length > 0
        @activateTab name
        break

  statusChanged: ({status, oldStatus}) ->
    prio =
      progress: 0
      error: 20
      warning: 10
      ready: 0
    if prio[status] >= prio[oldStatus] or status is 'progress'
      @status.setAttribute 'data-status', status
    unless status is 'progress'
      @disposeCancelBtnClicked()

  showItem: (item) ->
    @activateTab item.severity
    @items.showItem item

  getActiveTab: ->
    @buttons.getActive()

  createTab: (name, opts) ->
    unless name in @buttons.buttonNames()
      @buttons.createButton name, opts
    unless @getActiveTab()?
      @activateTab @buttons.buttonNames()[0]

  setProgress: (progress) ->
    @progressBar.setProgress progress

  onActionCancelled: (callback) ->
    @cancelBtnClick = new SubAtom
    @cancelBtnClick.add @cancelBtn, 'click', -> callback()
    @style.setProperty 'visibility', 'visible'
    @cancelBtn.style.setProperty 'visibility', 'visible'
    new Disposable => @disposeCancelBtnClicked()

OutputPanelElement =
  document.registerElement 'ide-haskell-panel',
    prototype: OutputPanelView.prototype

module.exports = OutputPanelElement