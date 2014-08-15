contactEntry = ->
  {
    template: "<ons-list-item ng-class='{ selected: city.selected }' modifier='tappable'>{{city.cityName}}</ons-list-item>"
    restrict: 'E'
    replace: true
    link: (scope, element, attrs, controller) ->

      element.on 'click', (ev) ->
        scope.toggleCity(scope.city)
  }

module.exports = contactEntry
