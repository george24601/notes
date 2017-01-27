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

//extend


//template

//templateHelpers
