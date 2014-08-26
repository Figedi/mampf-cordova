item = ['$onsen', ($onsen) ->

  restrict: 'E'
  # NOTE: This element must coexists with ng-controller.
  # Do not use isolated scope and template's ng-transclude.
  replace: false
  transclude: false

  link: (scope, elem, attrs) ->
    elem.on 'dragleft', ($event) ->
      elem.css(left: "#{$event.gesture.deltaX}px")
    templater = $onsen.generateModifierTemplater(attrs)
    elem.addClass('list__item ons-list-item-inner')
    elem.addClass(templater('list__item--*'))


]
module.exports = item
