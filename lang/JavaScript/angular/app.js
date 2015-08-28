(function() {
	var app = angular.module('store', []);
	app.controller('StoreController', function() {
		this.product = gems;
	} );

	app.controller('PanelController', function() {
		this.tab = 1
		this.selectTab = funciton(setTab) {
			this.tab = setTab;
		};
		this.isSelected=function(checkTab){
			return this.tab === checkTab
		};
	} );

	var gems = [{
		name : "gem name!", canPurchase: false
		

	}];



}) () ; //wrap it in a closure
