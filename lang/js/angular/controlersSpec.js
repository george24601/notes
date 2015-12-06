describe('PhoneListCtrl', function(){

	beforeEach(module('phonecatApp')); //load moddule

	it('should create "phones" model with 3 phones', inject(function($controller) { //inject $controller service
		var scope = {},
		ctrl = $controller('PhoneListCtrl', {$scope:scope}); //$controller service provided by angular

	expect(scope.phones.length).toBe(3);
	}));

});

//testing with fakehttp, jsmine and angular-mock


