require 'lib/element'

class Author < Element
  attr_reader :name, :email
  def initialize(name,email)
    @name = name
    @email = email
  end
  
  def ==(other)
    self.name == other.name && self.email == other.email
  end
end