validate = ->
    {
        restrict: 'A'
        require: 'ngModel'
        link: (scope, elem, attr, ngModel) ->
            console.log "it works"
            scope.$watch attr.sharedValidate, (sharedValue) ->
                #hardcoding since automatic behaviour didnt really work
                modelValue = parseInt(ngModel.$viewValue.replace(':', ''))
                sharedValue = parseInt(sharedValue.replace(':', ''))
                isValid = true #always set true to empty/default
                if attr.ngModel == "request.startTime" #we need to be less than validate value
                    isValid = modelValue <= sharedValue
                    ngModel.$setValidity('lessThan', isValid)
                else if attr.ngModel == "request.endTime" #we need to be greater than validate value
                    isValid = modelValue >= sharedValue
                    ngModel.$setValidity('greaterThan', isValid)

            scope.$watch attr.ngModel, (newValue) ->
                console.log "value - model", newValue
                console.log "ngModel", attr.sharedValidate
                #hardcoding since automatic behaviour didnt really work
                ###modelValue = parseInt(ngModel.$viewValue.replace(':', ''))
                newValue = parseInt(newValue.replace(':', ''))
                isValid = true #always set true to empty/default
                if attr.ngModel == "request.startTime" #we need to be less than validate value
                    isValid = modelValue <= newValue
                    ngModel.$setValidity('lessThan', isValid)
                else if attr.ngModel == "request.endTime" #we need to be greater than validate value
                    isValid = modelValue >= newValue
                    ngModel.$setValidity('greaterThan', isValid)###
    }

module.exports = validate

# app.directive('shareValidate', function () {
# return {
#     restrict: 'A',
#     require: 'ngModel',
#     link: function(scope, elem, attr, ctrl) {
#         scope.$watch(attr.shareValidate, function(newArr, oldArr) {
#             var sum = 0;
#             angular.forEach(newArr, function(entity, i) {
#                 sum += entity.share;
#             });
#             if (sum === 100) {
#                 ctrl.$setValidity('share', true);
#                 scope.path.offers.invalidShares = false;
#             }
#             else {
#                 ctrl.$setValidity('share', false);
#                 scope.path.offers.invalidShares = true;
#             }
#         }, true); //enable deep dirty checking
#     }
# };
# });
