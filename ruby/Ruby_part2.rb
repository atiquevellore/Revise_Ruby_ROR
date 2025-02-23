#begin rescue ensure

def dividebyzero   
    begin
        1/0
    rescue ZeroDivisionError => e
        return "error message #{e.message}"
    ensure
        puts "acts a finally runs irrespective of begin or rescue block"
    end
end

puts dividebyzero

#blocks are similar to callback functions

[1,2,3,4].each {|num| num *2}
#yield proc


#In Ruby, yield is a keyword used to pass control from a method to a block provided during the method's invocation
#yield basic way of calling
def cube(arr)
    yield arr
end

print cube([1,2,3,4,5]) {|arr| arr.map {|ele| ele**3}}


def with_file(filename)
    file = File.open(filename, "w")
    yield
    file.close
end

with("test.txt") {|file| file.write("hello ruby")}

#procs are similar to blocks but can used again and again 
square = Proc.new {|ele| ele*ele }


puts "other way using procs #{[2,4,6,8].collect(&square)}"

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
class Test
    #class scope variable 
    @@count = 0
    #constructor
    def initialize(name)
        @name = name #object instance variable @
    end

    def incrementcount
        @@count+=1
    end

    def printcountandnamevalue
        puts "name:#{@name}"
        puts "count: #{@@count}"

    end
end

#object
obj1 = Test.new("atique")
obj1.incrementcount
puts  obj1.printcountandnamevalue


#getter and setter method variables

class Person

    attr_accessor :name,:age

    def initialize(name,age)
        @name = name
        @age = age
    end
    
    def printdetails
        print "my name is #{@name}   and age is #{@age}"
    end
end

p1 = Person.new("atique", 24)
puts p1.age

p1.age = 34
p1.printdetails

#inheritance



class DerivedPerson < Person

    def initialize(name,age)
        super(name,age)
    end
end

d1 = DerivedPerson.new("laeeq",34)
d1.printdetails

#function overriding
# works for same function name in different classes with different number of args
class Person

    attr_accessor :name,:age

    def initialize(name,age)
        @name = name
        @age = age
    end
    
    def printdetails
        puts "my name is #{@name}   and age is #{@age}"
    end
    
    def overridingfn(objname)
        puts "base class obj #{objname}"
    end
end

p1 = Person.new("atique", 24)
puts p1.age

p1.age = 34
p1.printdetails
p1.overridingfn("p1")



#inheritance

class DerivedPerson < Person

    def initialize(name,age)
        super(name,age)
    end
      
    def overridingfn(objname)
      puts "derived class obj #{objname}"
    end
    
end

d1 = DerivedPerson.new("laeeq",34)
d1.printdetails
d1.overridingfn("d1")

#access modifiers in ruby
#public

class PublicClass
  
  
  
    def public_method
      puts "it is a public method"
    end
    
    def super_method(name)
      puts 'super method params'
    end
    
    def acess_private_method
      private_method
    end
    
    private
    def private_method
      puts "it is a private method "
    end
    
    protected
    def protected_method
      puts "it is a protected method"
    end
  end
  
  class Derived < PublicClass
      def initialize
        super
      end
      
      def accessing_protected_method
        protected_method
      end
  end
  
  #instance of the class
  
  p1 = PublicClass.new 
  puts p1.public_method
  
  d1 = Derived.new
  puts d1.public_method
  puts d1.accessing_protected_method
  #puts p1.acess_private_method
  
  puts p1.private_method #cannot accessed
  puts p1.protected_method #cannot accessed

  overall description 
  private methods are limited to class level can be acessed by methods
  of the class and but it cannot be accessed by instances of class

  public methods can be accessed by instances of a class and also 
  can be accessed by subclasses or inherited classes

  protected methods can be accessed by method inside the class and
  subclasses or inherited methods


=begin
#difference between super and super()
super
Use when you want to pass the same arguments to the superclass method
super()
Use when you want to call the superclass method without passing any arguments
=end


module CIRCLE
    PI_VALUE = 3.14

    def self.circumference(r)
        2*PI_VALUE*r
    end
end

class Mathop
    include CIRCLE
    def printcirucm(radius)
        CIRCLE.circumference(radius)
    end
end

m1 = Mathop.new

puts m1.printcirucm(10.5)




diff between module include and extend 

When you want to share methods between multiple
 classes that need to use these methods as instance methods, you use include.


 In summary, the main difference between include and 
 extend is how the module methods are added to the class. 
 include adds the module's methods as instance methods of the class,
  while extend adds the module's methods as class methods of the class.

module Module_test
    def func
        puts "M - in module"
    end
end

class A
    include Module_test
end
includes provides objects to access the module method

class B 
    extend Module_test
end

When you want to share methods that should be available as class methods rather than instance methods, you use extend.
