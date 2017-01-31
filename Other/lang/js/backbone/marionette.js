//templateHelpers: create helper methos that can be called from within your templates
//also a good place to add data not returned from serializeData

var model = new Backbone.Model({
    name: "Marionette",
    decimal: 1
});

var MyView = Marionette.ItemView.extend({
    template: "#my-template",

    templateHelpers: function () {
          return {
                  showMessage: function(){
                    //to access data , need to prefix the data with "this"
                            return this.name + " is the coolest!";
                          },

                  percent: this.model.get('decimal') * 100
                };
        }
});

//ItemView example starts
<script id="some-template" type="text/html">
    <ul>
      <% _.each(items, function(item){ %>
            <li> <%= item.someAttribute %> </li>
              <% }); %>
    </ul>
  </script>

var MyItemsView = Marionette.ItemView.extend({
    template: "#some-template"
});

var view = new MyItemsView({
    collection: someCollection
});

//end of ItemView example

//example with simple model
var myModel = new MyModel({foo: "bar"});

new MyItemView({
    template: "#myItemTemplate",
    model: myModel
});

MyItemView.render();

<script id="myItemTemplate" type="template">
    Foo is: <%= foo %>
</script>

//example with a collection

var myCollection = new MyCollection([{foo: "bar"}, {foo: "baz"}]);

new MyItemView({
    template: "#myCollectionTemplate",
  //the result is passed in as an "items" array
    collection: myCollection
});

MyItemView.render();

<script id="myCollectionTemplate" type="template">
    <% _.each(items, function(item){ %>
          Foo is: <%= foo %>
          <% }); %>
  </script>
