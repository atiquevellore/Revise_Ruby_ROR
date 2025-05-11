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

#varaiables
#ruby does need the variable type it automatically assume based on the provided value

#integer variable
a = 10

#float variable
b = 10.5

#string variables
c = "hello world"
c.upcase! #convert string characters to uppercase
c.downcase! #convert string characters to downcase

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


#str built in functions
str = "hello"
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


for i in 0..arr.length-1
    print arr[i]
end



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

#json

fakejsondata = [
{
    "userId": 1,
    "id": 1,
    "name": "first user",
    "subject": "english",
    "marks":  "100"
},
{
  "userId": 2,
    "id": 2,
    "name": "second user",
    "subject": "maths",
    "marks":  "90"
} ,
{
  "userId": 3,
    "id": 3,
    "name": "third user",
    "subject": "maths",
    "marks":  "100"
    } ,
{
  "userId": 4,
    "id": 4,
    "name": "fourth user",
     "subject": "english",
    "marks":  "60"
},
{
  "userId": 5,
    "id": 5,
    "name": "fourth user",
     "subject": "english",
    "marks":  "100"
}
]

grouped_data = {}


fakejsondata.each do |record|
    name = record[:name]
    marks = record[:marks]

    #checking hash
    if grouped_data[name] 
          grouped_data[name] = marks if grouped_data[name] < marks
    else
        grouped_data[name] = marks
    end
end

puts grouped_data

#group the json data based on specific element

record.group_by {|item| item[:id]}