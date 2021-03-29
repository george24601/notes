In Active Record, objects carry both persistent data and behavior which operates on that data. Active Record takes the opinion that ensuring data access logic as part of the object will educate users of that object on how to write to and read from the database.

Model Class - Singular with the first letter of each word capitalized (e.g., BookClub).
Database Table - Plural with underscores separating words (e.g., book_clubs).

Foreign keys - These fields should be named following the pattern singularized_table_name_id (e.g., item_id, order_id). These are the fields that Active Record will look for when you create associations between your models.
Primary keys - By default, Active Record will use an integer column named id as the table's primary key 

created_at - Automatically gets set to the current date and time when the record is first created.
updated_at - Automatically gets set to the current date and time whenever the record is created or updated.
lock_version - Adds optimistic locking to a model.
type - Specifies that the model uses Single Table Inheritance.
`(association_name)_type` - Stores the type for polymorphic associations.
`(table_name)_count` - Used to cache the number of belonging objects on associations. For example, a comments_count column in an Article class that has many instances of Comment will cache the number of existent comments for each article.

The rule is that if you do not explicitly render something at the end of a controller action, Rails will automatically look for the action_name.html.erb template in the controller's view path and render it. So in this case, Rails will render the app/views/books/index.html.erb file.

If you want to render the view that corresponds to a different template within the same controller, you can use render with the name of the view

render tells Rails which view (or other asset) to use in constructing a response. The redirect_to method does something completely different: it tells the browser to send a new request for a different URL

Sometimes inexperienced developers think of redirect_to as a sort of goto command, moving execution from one place to another in your Rails code. This is not correct. Your code stops running and waits for a new request from the browser. It just happens that you've told the browser what request it should make next, by sending back an HTTP 302 status code.

The naming convention of controllers in Rails favors pluralization of the last word in the controller's name, although it is not strictly required (e.g. ApplicationController). For example, ClientsController is preferable to ClientController

