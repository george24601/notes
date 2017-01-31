{
    "page": 1,
      "limit": 10,
      "total": 2,
      "books": [
            {"id": 1, "title": "Pride and Prejudice"},
            {"id": 4, "title": "The Great Gatsby"}
          ]
}

//use parse to handle non-default input
var Books = Backbone.Collection.extend({
  url: '/books'
  parse: function(data) {
    return data.books;
  }
});

//extend: create custom view class
var DocumentRow = Backbone.View.extend({

  //called when the view is first created, alternatively, can be new View([options])
    initialize: function() {
          this.listenTo(this.model, "change", this.render);
        },

//template: when rendering your view, you can access instance data
  template: function(){
  },

  //render defaults to no-op

});

