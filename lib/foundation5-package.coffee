Foundation5PackageView = require './foundation5-package-view'
{CompositeDisposable} = require 'atom'

module.exports = Foundation5Package =
  foundation5PackageView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->

  deactivate: ->

  serialize: ->
    foundation5PackageViewState: @foundation5PackageView.serialize()
