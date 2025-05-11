# Begin, rescue, ensure example
# Demonstrates exception handling in Ruby with `begin`, `rescue`, and `ensure`.
def divide_by_zero
    begin
        1 / 0
    rescue ZeroDivisionError => e
        return "Error message: #{e.message}"
    ensure
        puts "Acts as finally, runs irrespective of begin or rescue block"
    end
end


puts divide_by_zero

# Blocks example
# Demonstrates the use of blocks with the `each` method.
[1, 2, 3, 4].each { |num| puts num * 2 }

# Yield example
# Demonstrates the use of `yield` to pass control to a block.
def cube(arr)
    yield arr
end

print cube([1, 2, 3, 4, 5]) { |arr| arr.map { |ele| ele**3 } }

# File handling with yield
# Demonstrates file handling with a block using `yield`.
def with_file(filename)
    file = File.open(filename, "w")
    yield file
    file.close
end

with_file("test.txt") { |file| file.write("Hello Ruby") }

# Procs example
# Demonstrates the use of `Proc` objects.
square = Proc.new { |ele| ele * ele }
puts "Using procs: #{[2, 4, 6, 8].collect(&square)}"

# Lambda example
# Demonstrates the use of lambdas, which are similar to Procs but stricter in argument checking.
square_lambda = ->(ele) { ele * ele }
puts "Using lambda: #{[2, 4, 6, 8].map(&square_lambda)}"


def square(arr)
    yield arr
end
print square([1,2,3,4,5]) {|arr| arr.map(&square)}

#object oriented programming

#class template

=begin
difference @ and @@
@  belongs to single instance
@ is scoped at class level variable is can be modified and share across class
level variables
=end
#global variable
$gvar = "globak"

# Object-oriented programming
# Demonstrates global, class, and instance variables.
$gvar = "global"

class Test
    @@count = 0 # Class variable

    def initialize(name)
        @name = name # Instance variable
    end

    def increment_count
        @@count += 1
    end

    def print_count_and_name
        puts "Name: #{@name}"
        puts "Count: #{@@count}"
    end
end

obj1 = Test.new("Atique")
obj1.increment_count
obj1.print_count_and_name

# Getter and setter methods
# Demonstrates the use of `attr_accessor` for getter and setter methods.
class Person
    attr_accessor :name, :age

    def initialize(name, age)
        @name = name
        @age = age
    end

    def print_details
        puts "My name is #{@name} and age is #{@age}"
    end
end

p1 = Person.new("Atique", 24)
puts p1.age
p1.age = 34
p1.print_details

# Inheritance
# Demonstrates inheritance using the `DerivedPerson` class.
class DerivedPerson < Person
    def initialize(name, age)
        super(name, age)
    end
end

d1 = DerivedPerson.new("Laeeq", 34)
d1.print_details

# Function overriding
# Demonstrates method overriding in the derived class.
class Person
    attr_accessor :name, :age

    def initialize(name, age)
        @name = name
        @age = age
    end

    def print_details
        puts "My name is #{@name} and age is #{@age}"
    end

    def overriding_fn(obj_name)
        puts "Base class object: #{obj_name}"
    end
end

class DerivedPerson < Person
    def initialize(name, age)
        super(name, age)
    end

    def overriding_fn(obj_name)
        puts "Derived class object: #{obj_name}"
    end
end

p1 = Person.new("Atique", 24)
p1.print_details
p1.overriding_fn("p1")

d1 = DerivedPerson.new("Laeeq", 34)
d1.print_details
d1.overriding_fn("d1")

# Access modifiers
# Demonstrates public, private, and protected methods.
class PublicClass
    def public_method
        puts "This is a public method"
    end

    def access_private_method
        private_method
    end

    private

    def private_method
        puts "This is a private method"
    end

    protected

    def protected_method
        puts "This is a protected method"
    end
end

class Derived < PublicClass
    def access_protected_method
        protected_method
    end
end

p1 = PublicClass.new
p1.public_method

d1 = Derived.new
d1.public_method
d1.access_protected_method

# Uncommenting the following lines will raise errors
# p1.private_method # Private methods cannot be accessed directly.
# p1.protected_method # Protected methods cannot be accessed outside the class hierarchy.


# Overall description:
# Private methods are limited to the class level. They can only be accessed 
# by other methods within the same class and cannot be accessed by instances 
# of the class.

# Public methods can be accessed by instances of a class and can also 
# be accessed by subclasses or inherited classes.

# Protected methods can be accessed within the same class and by subclasses,
# but not by objects of the class outside of its methods or the subclass.

class Parent
    def public_method
      puts "I am public!"
    end
  
    protected
        def protected_method
        puts "I am protected!"
        end
end  
class Child < Parent
    def call_protected
      protected_method # Accessing protected method within the subclass
    end
end
  
  parent = Parent.new
  child = Child.new
  
  parent.public_method    # => "I am public!"
  parent.protected_method # => Error: NoMethodError, as protected is not accessible directly from outside
  
  child.call_protected    # => "I am protected!" (accessible within the subclass)
  

=begin
#difference between super and super()
super
Use when you want to pass the same arguments to the superclass method
super()
Use when you want to call the superclass method without passing any arguments
=end

#example of super()

class Animal
    def sound(speak)
        puts "Animal sound: #{speak}"
    end
end

class Dog < Animal
    super("Woof")
end

dog = Dog.new
dog.sound("Woof") # Calls the method from the Animal class

#example of super

class Animal
    def sound(speak)
        puts "Animal Sound"
    end
end

class Dog < Animal
    super()
end
dog = Dog.new
dog.sound # Calls the method from the Animal class


# Modules
# Demonstrates the use of modules for grouping related methods and constants.
module Circle
    PI_VALUE = 3.14

    def self.circumference(r)
        2 * PI_VALUE * r
    end
end

class MathOp
    include Circle

    def print_circumference(radius)
        Circle.circumference(radius)
    end
end

m1 = MathOp.new
puts m1.print_circumference(10.5)


#include vs extend
# `include` is used to mix in a module's methods as instance methods.
# `extend` is used to mix in a module's methods as class methods.
module MathOperations
    def add(a, b)
        a + b
    end

    def subtract(a, b)
        a - b
    end
end

class Calculator
    extend MathOperations # Class method
end

puts Calculator.add(5, 3) # => 8
puts Calculator.subtract(5, 3) # => 2

# `include` example
class MyClass
    include MathOperations # Instance method
end
obj = MyClass.new
puts obj.add(5, 3) # => 8
puts obj.subtract(5, 3) # => 2
# `extend` example
class MyClass
    extend MathOperations # Class method
end
obj = MyClass.new
puts obj.add(5, 3) # => 8
puts obj.subtract(5, 3) # => 2


#prepend 
# Demonstrates the use of `prepend` to add a module's methods before the class's methods.
module PrependModule
    def greet
        puts "Hello from PrependModule!"
    end
end

class MyClass
    prepend PrependModule

    def greet
        puts "Hello from MyClass!"
    end
end

obj = MyClass.new
obj.greet # => "Hello from PrependModule!"

# Constants
# Demonstrates the use of constants in Ruby.
class ConstantsExample
    PI = 3.14

    def self.print_pi
        puts "Value of PI: #{PI}"
    end
end

ConstantsExample.print_pi


#Ruby doesn't support multiple inheritance directly. 
#If Ruby allowed it, a class could inherit from multiple classes, causing conflicts. 
# multiple inheritance usin mixin

module A

    def method_a
        puts "Method A"
    end
end

module B
    def method_b
        puts "Method B"
    end
end

class C
    include A
    include B
end
c = C.new
c.method_a
c.method_b


 # multi level inheritance
class A
    def method_a
        puts "Method A"
    end
end

class B < A
    def method_b
        puts "Method B"
    end
end

class C < B
    def method_c
        puts "Method C"
    end
end

c = C.new
c.method_a # Inherited from A
c.method_b # Inherited from B
c.method_c # Defined in C
