#comments

#single line comment

=begin
multi
line
comments
=end

#printing

print "single line statement without a new line at end"
puts "single line statement with a new line"

> print("hello world")
hello world => nil
> puts("hello world")
hello world
 => nil

#varaiables
#ruby does need the variable type it automatically assume based on the provided value

#integer variable
a = 10

#float variable
b = 10.5

3.1.4 :010 > a = 3.5
 => 3.5
3.1.4 :011 > a.class #.class is used to determine type of a variable
 => Float
3.1.4 :012 >

#string variables
c = "hello world"
c.upcase! #convert string characters to uppercase
c.downcase! #convert string characters to downcase


# include function used to check str is present it only works for matching case 
# !(bang operator saves the value in ruby)
3.1.4 :024 > b.downcase!
 => "hello str"
3.1.4 :025 > b.include?("str")
 => true

#string interploation it can be used in logging
puts "display #{C}"

#string iteration
c.each_char {|char| puts char}

#gsub vs sub
#gsub replace all the occurencess with given replacement character
#sub replaces only  the first occurence character
str1 = "hello"
str1.gsub('l','b')
str1.sub('b','c')

#getting user input 
puts "enter the user input"
input = gets.chomp();


#swapping two numbers without using inbuilt functions or temp variable
a = 10
b = 20 

a=a+b
b = a-b
a = a-b

#str built in functions
str = "hello"
str.length # gives length of the str
str.reverse
str.split('') #converts str into arr
str.join(',') #  join the arrays of str chars into a single str



#control flow statements
#if
if 10 > 5
    print "statement"
else
    print "statement"
end

#if elsif else end

if 8 > 9
    puts "will not be executed"
elsif 8 > 7
    put "will be executed"
else
     put "will not be executed"
end

# works only on false it will not loop

until 9 > 10
    puts "hello"
end

#arrays(indexing starts from zero)
arr = [1,2,3,4,5]
str_char_arr = ['h','e','l','l','o']

arr.length #provides the array
arr.slice(0,2) #proivdes elements with in the provided range

#inbuilt operations
arr.push(10) #adds an element at end of the array
arr.unshift(0) #adds an element at  beg of the array
arr.pop #remove last element from arr
arr.shift #removes first element from arr

#loop method

#for loop can be used while doing DSA

#inclusive range means included
#.. means it is inclusive range
#... means it is exclusive range

> for i in 1..10
>   puts i
> end
1
2
3
4
5
6
7
8
9
10
 => 1..10
3.1.4 :009 > for i in 1...10
3.1.4 :010 >   puts i
> end
1
2
3
4
5
6
7
8
9
 => 1...10
3.1.4 :012 >

3.1.4 :012 > arr = [1,2,3,4]
 => [1, 2, 3, 4]
3.1.4 :013 > for i in 0...arr.length
3.1.4 :014 >   puts arr[i]
3.1.4 :015 > end
1
2
3
4
 => 0...4
3.1.4 :016 >

# if you starting arr index with 1 then 
3.1.4 :022 > for i in 1...arr.length
3.1.4 :023 >   puts arr[i]
3.1.4 :024 > end
2
3
4
 => 1...4
3.1.4 :025 >



#not  recommended can lead to infinity
while i < 10
    puts i
    i+=1
end

#best way is to use each method
arr.each { |ele| puts "ele: #{ele}"}

#map and collect returns a new array based on code block
arr.map {|ele|  ele * 2} #[2,4,6,8]

#select is used to return condition based array
arr.select { |ele| ele > 3}

#sorting arr elements
arr.sort! #ascending order
arr.sort  { |a,b| b-a } #descending order

#hashes these are objects which contains key value pairs

h = Hash.new("default value")

h = {
    "name" => "atique"
    "age" => 24
    "DOB" => "13/12/1999"
}

#accessing has elements
h["name"]

#counting string of characters
3.1.4 :040 > str.each_char { |char| h[char]+=1 }
 => "helloworld"
3.1.4 :041 > h
 => {"h"=>1, "e"=>1, "l"=>3, "o"=>2, "w"=>1, "r"=>1, "d"=>1}
3.1.4 :042 >


3.1.4 :041 > h
 => {"h"=>1, "e"=>1, "l"=>3, "o"=>2, "w"=>1, "r"=>1, "d"=>1}
3.1.4 :042 > h.select{|key,value|  value <= 1 }
 => {"h"=>1, "e"=>1, "w"=>1, "r"=>1, "d"=>1}
3.1.4 :043 > h.select{|key,value|  value >= 2 }
 => {"l"=>3, "o"=>2}
3.1.4 :044 >


#looping through hash elements
h.each {|key,value| puts "key: #{key}, value #{value}"}

#function definition

def test(a,b)
    a+b
end

test(1,2)

def multipleargs(*args)
    args.each{|arg| puts args }
end

#function overloading does  not work in ruby
=begin 
Ruby does not support method overloading because it is a dynamically typed language 
it identifies method using function name not by the type of parameters or 
number of parameters if function with name and different in number of parameters is 
defined then it replaces the previous one
=end 
#function overloading 
def test(a)
    return a
end

def test(a,b)
    return a+b
end

puts test(10)
puts test(10+9)



multipleargs(1,2,,3,[1,3,5,7])

#grouping without using groupby

words = ["apple","banana", "cherry", "date", "fig", "grape"]


grouped = {}

words.each do |word|
    key = word.length
    group[key] ||= []
    group[key] << word
end

