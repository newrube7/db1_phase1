# here's a simple example of driving your design using tests.
# by running this code and solving the failing tests one by one
# you should be able to finish this challenge easily.
# ask for help if you get stuck.

# consider all the questions (Q:) as you encounter them

# in this universe ...
#   - people own pets
#   - pets eat and walk
#   - pets say things appropriate to their species

########################################################
# design the classes (partially complete)
########################################################
# Q: what classes, methods and attributes are missing?
# - most of your work will happen in this section
# - but you should not need to change any of the existing code, only add to it.

module Reality
  def passage_of_time
    @walked = false
    @fed = false
    @stretched = false
    p "time passes ..."
    # Q: what else will your class do "during" this method?

  end
end

class Pet
  include Reality

  def initialize
    @walked = false
    @fed = false
  end

  def walked?
    @walked
  end

  def fed?
    @fed
  end

  def eat!
    @fed = true
  end

  def rollover!
    p "#{self} rolled over!"
  end
end

class Dog < Pet

  def speak!
    "woof!"
  end

  def walk!
    @walked = true
    "happy dog."
  end
end

class Cat < Pet
  include Reality
  def initialize
    @stretched = false
  end

  def speak!
    "meow."
  end

  def stretched?
    @stretched
  end

  def stretch!
    @stretched = true
    "happy cat."
  end
end

class Person
  attr_accessor :pets
  def initialize
    @pets = []
  end

  def walk(pet_name)
    pet_name.walk!
  end

  def feed(pet_name)
    pet_name.eat!
  end

  def showoff_pet_tricks
    pets.each do |pet|
      pet.rollover!
    end
  end
end

########################################################
# create driver code to invoke the classes
########################################################
# Q: what minimal driver code do you need to get the tests to pass?
# - you might only end up with 3-5 lines of code right here

fido = Dog.new
precious = Cat.new
owner = Person.new


########################################################
# assertions
########################################################
# Q: how do these assertion functions work?  read and understand them
# - you definitely don't NEED to edit these functions to solve this challenge
# - but if you decide to change them to help you that's fine of course

def assert test
  raise "oops!" unless test
end

def assert_equal actual, expected
  raise "whoops! expected #{expected} but got #{actual}" unless expected == actual
end

def assert_false test
  raise "waat?" if test
end

def assert_empty collection
  raise "derp." unless collection.empty?
end

########################################################
# Q: what design is implied by these assertions?
# - you should not edit the code below this line
# - instead edit the code in your classes to make these tests pass
# - you will also need to add just a few lines of driver code as well

assert_equal fido.class, Dog
assert_equal precious.class, Cat
assert_equal owner.class, Person

# the dog can walk and remembers that it walked
assert_false fido.walked?
assert_equal fido.walk!, "happy dog."
assert fido.walked?

# but over time the dog needs more walking
assert fido.passage_of_time

assert_false fido.walked?

# the dog can eat and remembers that it ate
assert_false fido.fed?
assert fido.eat!
assert fido.fed?

# but over time the dog needs more food
fido.passage_of_time
assert_false fido.fed?

# the dog can speak
assert_equal fido.speak!, "woof!"

# the cat can walk and remembers that it walked
assert_false precious.stretched?
assert_equal precious.stretch!, "happy cat."
assert precious.stretched?

# but over time the cat needs more walking
assert precious.passage_of_time
assert_false precious.stretched?

# the cat can eat
assert precious.eat!
assert_equal precious.speak!, "meow."

# people can have pets
assert_empty owner.pets
assert owner.pets << fido
assert_equal owner.pets.length, 1

assert owner.pets << precious
assert_equal owner.pets.length, 2

assert owner.pets.include? fido
assert owner.pets.include? precious


fido.passage_of_time
assert_false fido.walked?
assert owner.walk(fido)  # get the dog to say something
assert fido.walked?

precious.passage_of_time
assert_false precious.fed?
assert owner.feed(precious)  # get the cat to say something
assert precious.fed?

assert owner.showoff_pet_tricks # actually make the pets do something



