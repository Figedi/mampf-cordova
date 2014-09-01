item = ['$onsen', '_', '$timeout', ($onsen, _, $timeout) ->

  restrict: 'E'
  # NOTE: This element must coexists with ng-controller.
  # Do not use isolated scope and template's ng-transclude.
  replace: false
  transclude: false

  link: (scope, elem, attrs) ->
    $inAnimation = false
    $animationEnd = false
    templater = $onsen.generateModifierTemplater(attrs)
    elem.addClass('list__item ons-list-item-inner')
    elem.addClass(templater('list__item--*'))
    console.log "elem is", elem
    #box = angular.element('<div class="slideAnimation"></div>')
    elem.on 'click', ($event) ->
      return if $inAnimation
      if $animationEnd #is left
        elem.removeClass('slideAnimation ng-enter')
        elem.addClass('slideAnimation ng-leave')
        $inAnimation = true
        $timeout ->
          $inAnimation = false
          $animationEnd = false
          console.log "animation to right complete"
        , 250
      else #is normal
        elem.removeClass('slideAnimation ng-leave')
        elem.addClass('slideAnimation ng-enter')
        $inAnimation = true
        $timeout ->
          $inAnimation = false
          $animationEnd = true
          console.log "animation to left complete"
        , 250

]
module.exports = item
