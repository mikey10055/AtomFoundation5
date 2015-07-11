Foundation5PackageView = require './foundation5-package-view'
{CompositeDisposable} = require 'atom'

module.exports = Foundation5Package =
  foundation5PackageView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @foundation5PackageView = new Foundation5PackageView(state.foundation5PackageViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @foundation5PackageView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'foundation5-package:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @foundation5PackageView.destroy()

  serialize: ->
    foundation5PackageViewState: @foundation5PackageView.serialize()

  toggle: ->
    console.log 'Foundation5Package was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
