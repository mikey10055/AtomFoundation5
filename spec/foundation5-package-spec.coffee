Foundation5Package = require '../lib/foundation5-package'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "Foundation5Package", ->
  [workspaceElement, activationPromise] = []

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    activationPromise = atom.packages.activatePackage('foundation5-package')

  describe "when the foundation5-package:toggle event is triggered", ->
    it "hides and shows the modal panel", ->
      # Before the activation event the view is not on the DOM, and no panel
      # has been created
      expect(workspaceElement.querySelector('.foundation5-package')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'foundation5-package:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(workspaceElement.querySelector('.foundation5-package')).toExist()

        foundation5PackageElement = workspaceElement.querySelector('.foundation5-package')
        expect(foundation5PackageElement).toExist()

        foundation5PackagePanel = atom.workspace.panelForItem(foundation5PackageElement)
        expect(foundation5PackagePanel.isVisible()).toBe true
        atom.commands.dispatch workspaceElement, 'foundation5-package:toggle'
        expect(foundation5PackagePanel.isVisible()).toBe false

    it "hides and shows the view", ->
      # This test shows you an integration test testing at the view level.

      # Attaching the workspaceElement to the DOM is required to allow the
      # `toBeVisible()` matchers to work. Anything testing visibility or focus
      # requires that the workspaceElement is on the DOM. Tests that attach the
      # workspaceElement to the DOM are generally slower than those off DOM.
      jasmine.attachToDOM(workspaceElement)

      expect(workspaceElement.querySelector('.foundation5-package')).not.toExist()

      # This is an activation event, triggering it causes the package to be
      # activated.
      atom.commands.dispatch workspaceElement, 'foundation5-package:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        # Now we can test for view visibility
        foundation5PackageElement = workspaceElement.querySelector('.foundation5-package')
        expect(foundation5PackageElement).toBeVisible()
        atom.commands.dispatch workspaceElement, 'foundation5-package:toggle'
        expect(foundation5PackageElement).not.toBeVisible()
