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
=begin 
blocks are anoymous functions that can be passed into other function

the difference between  blocks and procs, lamda 
is that the blocks are not objects and procs and lamdas are the object


-Procs 

procs are the objects that encapsulate the block code 
they do not check the  number of arguments  and assign nil 
if they are missing

class User < ApplicationRecord
    scope :active,Proc.new { where(status: 'active')}
end

User.active


- lambdas 
lamdas are anyonomus function that are objects of Procs
the check the number of argument when invoked and raise error if there is
a mismatch

lambda_example = lambda {|name| puts "my  name is #{name}" }

lambda_example.call("david")


Ruby Clousures
a closure is a block of code that can be passed around and executed later, 
while retaining access to the variables in the scope where it was defined.

def greet
    name = "Alice"
    yield(name)
end

greet {|n| puts "Hello #{n}" }


demo_proc = Proc.new {|num1,num2| puts num1*num2}

[1].each(&demo_proc)
# will get nill error instead of number of arguments missing 


demo_lambda = lambda { |num1,num2| puts num1*num2}

will get number of arguments error

[1].each(&demo_lambda)


=end

#object oriented programming

#class template
=begin
difference @ and @@
@  belongs to single instance ,not share ,usecase used for  object specific initialization 
@@ is scoped at class level variable is can be modified and share across all instances and
subclasses 
level variables
=end

 => 0
3.1.4 :194 > class Car
3.1.4 :195 >   attr_accessor :name,:price
3.1.4 :196 >   @@total_cars = 0
3.1.4 :197 >   def initialize(name,price)
3.1.4 :198 >     @name = name
3.1.4 :199 >     @price = price
3.1.4 :200 >     @@total_cars+=1
3.1.4 :201 >   end
3.1.4 :202 >
3.1.4 :203 >   def car_data
3.1.4 :204 >     puts "name of car: #{@name} and price: #{@price}"
3.1.4 :205 >   end
3.1.4 :206 >
3.1.4 :207 >   def self.total_cars
3.1.4 :208 >     @@total_cars
3.1.4 :209 >   end
3.1.4 :210 > end
 => :total_cars
3.1.4 :211 > c1 = Car.new("swift dzire",700000)
 => #<Car:0x000071d12106be40 @name="swift dzire", @price=700000>
3.1.4 :212 > Car.total_cars
 => 1


#global variable
$gvar = "globak"


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

# p1.private_method # Private methods cannot be accessed directly.
# p1.protected_method # Protected methods cannot be accessed outside the class hierarchy.

# Public methods can be accessed by anyone — both inside and outside the class.
# They can be called by instances of the class and by subclasses.

# Protected methods can be accessed within the class and by instances of the same
# class or subclasses. They cannot be accessed directly from outside the class
# (e.g., instance.method will fail if method is protected).

# Private methods can only be accessed within the same class, without an explicit
# receiver. Even other instances of the same class cannot call them directly.


class Person
  private

  def secret
    "Ruby is fun"
  end

  def say_secret
    secret         # ✅ works (no receiver)
  end

  def leak_secret(other)
    other.secret   # ❌ error! can't call private method with explicit receiver
  end
end

p1 = Person.new
p2 = Person.new

puts p1.say_secret         # ✅ works
puts p1.leak_secret(p2)    # ❌ NoMethodError

class Person
  def initialize(age)
    @age = age
  end

  def older_than?(other)
    self.age > other.age   # ✅ allowed with explicit receiver
  end

  protected

  def age
    @age
  end
end

p1 = Person.new(30)
p2 = Person.new(25)

puts p1.older_than?(p2)  # ✅ true
puts p1.age              # ❌ NoMethodError


# Difference between super and super()
# super
#   - Calls the superclass method with the same arguments as the current method.
# super()
#   - Calls the superclass method with no arguments, regardless of the current method's arguments.


You're not alone! `super`, `super()`, and `super(args)` **can be confusing at first** — but once you see them all side-by-side, it clicks. Let's break them down **with clear and complete examples**.

---

## 🧠 Understanding `super` Variants in Ruby

| Syntax       | What it does                                                  |
| ------------ | ------------------------------------------------------------- |
| `super`      | Calls parent method with **same arguments** as current method |
| `super()`    | Calls parent method with **no arguments**                     |
| `super(arg)` | Calls parent method with **custom arguments**                 |

---

## ✅ Let's define a base class: `Animal`

```ruby
class Animal
  def speak(sound = "generic sound")
    puts "Animal speaks: #{sound}"
  end
end
```

---

### 1️⃣ `super`: Passes same arguments as the current method

```ruby
class Dog < Animal
  def speak(sound)
    puts "Dog prepares to speak"
    super  # passes `sound` to Animal#speak
    puts "Dog finished speaking"
  end
end

Dog.new.speak("Woof")
```

🟢 **Output:**

```
Dog prepares to speak
Animal speaks: Woof
Dog finished speaking
```

---

### 2️⃣ `super()`: Passes **no arguments**, even if this method received some

```ruby
class Dog < Animal
  def speak(sound)
    puts "Dog prepares to speak"
    super()  # ignores sound, calls Animal#speak with no args
    puts "Dog finished speaking"
  end
end

Dog.new.speak("Woof")
```

🟡 **Output:**

```
Dog prepares to speak
Animal speaks: generic sound
Dog finished speaking
```

---

### 3️⃣ `super("Bark")`: Passes **custom arguments**

```ruby
class Dog < Animal
  def speak(sound)
    puts "Dog prepares to speak"
    super("Bark")  # forces "Bark" to be passed regardless of input
    puts "Dog finished speaking"
  end
end

Dog.new.speak("Woof")
```

🟢 **Output:**

```
Dog prepares to speak
Animal speaks: Bark
Dog finished speaking
```

---

## ✅ Bonus: With `initialize` methods

```ruby
class Animal
  def initialize(name)
    puts "Animal initialized with name: #{name}"
  end
end

class Dog < Animal
  def initialize(name, breed)
    super(name)  # pass only name to Animal
    puts "Dog initialized with breed: #{breed}"
  end
end

Dog.new("Bruno", "Labrador")
```

🟢 **Output:**

```
Animal initialized with name: Bruno
Dog initialized with breed: Labrador
```

---

## ✅ Summary Chart

| Use           | Effect                                 |
| ------------- | -------------------------------------- |
| `super`       | Passes all current arguments to parent |
| `super()`     | Passes **no** arguments                |
| `super(x, y)` | Passes only **specified** arguments    |

---

Let me know if you want to practice a small exercise with all 3 — happy to help!


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



#include, prepend, extend

module A 

    def Hello 
        "Hello from module A"
    end
end

module B 

    def Hello 
        "Hello from module B"
    end
end

class C
    include A 
    extend B 
    prepend B

    def Hello 
        "Hello from class C"
    end 

    
end