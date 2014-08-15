contactEntry = ->
  {
    template: "<ons-list-item modifier='tappable'>{{contact.displayName}}</ons-list-item>"
    restrict: 'E'
    replace: true
    link: (scope, element, attrs, controller) ->

      element.on 'click', (ev) ->
        element.toggleClass('selected')
        scope.toggleContact(scope.contact)
  }

module.exports = contactEntry
