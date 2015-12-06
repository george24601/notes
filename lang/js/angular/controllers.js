//app/js/controllers.js

var phonecatApp = angular.module('phonecatApp', []); //dependency module goes here

phonecatApp.controller('PhoneListCtrl', ['$scope', '$http',
    function ($scope, $http) {
      $http.get('phones/phones.json').success(function(data) {
        $scope.phones = data;
      });

      $scope.orderProp = 'age';
    }]);
