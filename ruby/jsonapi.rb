#By default, attributes are read directly from the model property of the same name. In this example, name is expected to be a property of the object being serialized:

class MovieSerializer
  include JSONAPI::Serializer

  attribute :name

  #Custom attributes that must be serialized but do not exist on the model can be declared using Ruby block syntax:
  attribute :name_with_year do |object|
    "#{object.name} (#{object.year})"
  end

  #Attributes can also use a different name by passing the original method or accessor with a proc shortcut
  attribute :released_in_year, &:year
end

hash = MovieSerializer.new(movie).serializable_hash
json_string = MovieSerializer.new(movie).serializable_hash.to_json


