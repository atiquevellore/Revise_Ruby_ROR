#retrieving a single object

find method

#example : find the customer with primary key(id) 10
customer = Customer.find(10)
#raises ActiveRecordNotFound Exception when record is not found

#find the customer with primary 1,10
customers = Customer.find([1,10])

# find the customer with store_id 3 and id 17
customers = Customer.find([3,17])

take method
The take method retrieves a record without any implicit ordering. For example:

customer = Customer.take #retrieves single record
customer = Customer.take(3) #retrieves first 3 records

----
first method
The first method finds the first record ordered by primary key

example
customer = Customer.first
customer = Customer.first(3) #return first 3 results

last method 
The last method finds the last record ordered by primary key (default). For example:

example
customer = Customer.last
customer = Customer.last(3) return last 3 records

find_by finds the first record matching some conditions use ! this to raise ARNF
name = Customer.find_by first_name: 'Lifo'


irb> customer = Customer.last
=> #<Customer id: 10, store_id: 5, first_name: "Joe">
irb> Customer.find_by(id: customer.id_value) # Customer.find_by(id: 10)
=> #<Customer id: 10, store_id: 5, first_name: "Joe">

retrieving multiple objects in batches
find_each


# What is find_each?
# Imagine you have a huge list of items,
#  like a list of all the people in a big city. 
#  You want to go through each person's information one by one.
#   If you try to take all of them at once, 
#   it might be too much to handle and your 
#   system could slow down or even crash.

# How find_each Helps:
# Instead of grabbing all the people at once, 
# find_each takes them in small, manageable groups (batches).
#  It picks up, say, 100 people at a time, looks at each one,
#   and then moves on to the next group of 100, and so on.

example:-
Customer.find_each do |customer|
    NewsMailer.weekly(customer).deliver_now
end

options for find_each
batch_size
Customer.find_each(batch_size: 5000) do |customer|
    NewsMailer.weekly(customer).deliver_now
end

start , finish
Customer.find_each(start: 3000, finish: 10000) do |customer|
    NewsMailer.weekly(customer).deliver_now
end

order (deafult asc)

Customer.find_each(order :desc) do |customer|
    NewsMailer.weekly(customer).deliver_now
end

find_in_batches 

example
Customer.find_in_batches do |customers|
    export.add_customers(customers)
  end

  same options as the above 


conditions(where)
Book.where("title = 'Introduction to Algorithms'")
Array conditions

example
Book.where("title=?", params[:title])

placeholder conditions
example
Book.where( "created_at >= :start_date AND created_at <=:end_date",{start_date: params[:start_date], end_date: params[:end_date]})

LIKE
Book.where("title LIKE ?", Book.sanitize_sql_like(params[:title] + "%"))

hash conditions
Book.where('out_of_print' => true)

Range conditions
Book.where(created_at: (Time.now.midnight-1.day)..Time.now.midnight)

shorter syntax for the above example
Book.where(created_at:  (Time.now.midnight-1.day)..)

NOT conditions
Customer.where.not(orders_count: [1,3,5])
Customer.where.not(nullable_country: nil)


OR conditions
Customer.where(lastname: 'smith').or(Customer.where(orders_count: [1,3,5]))

AND conditions(chaining multiple where conditions)
Customer.where(lastname: 'smith').where(orders_count: [1,3,5])


Customer.where(id: [1,2]).and(Customer.where(id: [2,3]))

#ordering

#order by created_at field
Book.order(:created_at)
Book.order(created_at: :desc)
#OR
Book.order("created_at")
Book.order("created_at DESC")

order by multiple fields
Book.order(title: :asc, created_at: :desc)

order joined table
Book.includes(:author).order('books.print_year desc', 'authors.name asc')


#Selecting Specific Fields#
Book.select(:isbn,:out_of_print)

#select with distinct
Customer.select(:last_name).distinct

#limit and offset
Customer.limit(5)

Customer.limit(5).offset(30)


#group 
Order.select("created_at").group("created_at")

#get the total of grouped items
Order.group(:status).count

#having conditions
Order.select("created_at as order_date, sum(total) as total_price").group("created_at").having("sum(total) > ?", 200)


#reselect
Book.select(:title, :isbn).reselect(:created_at)

#reverse_order
Book.where("author_id > 10").order(:year_published).reverse_order


#locking Records for update

Active record provides two locking mechanisms
* optimistic locking
* Pessimistic locking

Optimistic locking allows multiple users to access the 
same record for edits, and assumes a minimum of conflicts 
with the data. It does this by checking whether another 
process has made changes to a record since it was opened. 
An ActiveRecord::StaleObjectError exception is thrown 
if that has occurred and the update is ignored.

In order to use optimistic locking a table needs column lcoking_version:integer

each time recodr is updated ,Active Record increments the lock_version column,
if an updated request is made with lesser value lock_version that is already is present then it raise_server_error!
ActiveRecordge::StaleObjectError

c1 = Customer.find(1)
c2 = Customer.find(1)

c1.first_name = "Atique"
c1.save

c2.first_name = "Bokhari"
c2.save #raises an Stale Object error


Pessimistic locking prevents dead lock transaction using lock method

Book.transaction do
    book = Book.lock("LOCK IN SHARE MODE").find(1)
    book.increment!(:views)
end

12 14 18  19

joins

raw sql using joins
Author.joins("INNER JOIN books ON books.author_id =  authors.id AND books.out_of_print = FALSE")


#using array or hash named associations
Book.joins(:reviews)

#joining multiple Associations
Book.joins(:author, :reviews)

#nested association
Author.joins(books: [{reviews: {customer: :orders}, :supplier}])

SELECT authors.* FROM authors
  INNER JOIN books ON books.author_id = authors.id
  INNER JOIN reviews ON reviews.book_id = books.id
  INNER JOIN customers ON customers.id = reviews.customer_id
  INNER JOIN orders ON orders.customer_id = customers.id
INNER JOIN suppliers ON suppliers.id = books.supplier_id


#specifying conditions on the joined table
time_range = (Time.now.midnight - 1.day)..Time.now.midnight 
Customer.joins(:order).where('order.created_at' => time_range).distinct


left outer join
Customer.left_outer_join
s(:reviews).distinct.select('customers.*',COUNT(reviews.*) AS reviews_count).group('customers.id')

associated and :missing
Customer.where.associated(:reviews) #Which means "return all customers that have made at least one review".

Customer.where.missing(:reviews) #return all customers that have not made any reviews



#N+1 problem easy way to understand than n number of tutorials

example
books  = Book.limit(10) # fetches 10 books in a single query

books.each do |book|
    puts book.author.lastname #performs 10 queries results in n+1 query
end

Solution to N+1 query

includes

books = Book.includes(:author).limit(10)




books.each do |book|
    puts book.author.last_name
end #this will execute 2 queries 
# SELECT books.* FROM books LIMIT 10
# SELECT authors.* FROM authors
#   WHERE authors.id IN (1,2,3,4,5,6,7,8,9,10)

Customer.includes(:orders, :reviews) #multiple association eager loading


conditons on includes 
Author.includes(:books).where(books: {out_of_print: true})

preload(but this not run the conditons )


books = Book.preload(:author).limit(10)

books.each do |book|
    puts book.author.last_name
end #this will execute 2 queries 
Calculations

Customer.count

Customer.includes(:orders).where(first_name: 'Ryan', orders: {status: 'Shipped'}).count

Order.average("subtotal")
Order.minimum("subtotal")
Order.maximum("subtotal")
Order.sum("subtotal")

existence of objects
Customer.exists?(1)
Customer.exists?(id: [1,2,3])
Customer.where(first_name:'Ryan').exists?

any ,many
Book.where(out_of_print: true).any?
Book.where(out_of_print: true).many?

# via an association
Customer.first.orders.any?
Customer.first.orders.many?

18  19

14 Scopes
Scoping allows you to specify
 commonly-used queries which can be referenced 
 as method calls on the association objects or models. 
 With these scopes, you can use every method previously 
 covered such as where, joins and includes. 
 All scope bodies should return an ActiveRecord::Relation or 
 nil to allow for further methods (such as other scopes) to be called on it.

example
class Book < ApplicationRecord
    scope :out_of_print, -> {where(out_of_print: true)}
end

#usecase
Book.out_of_print
if book is associated with Author
author = Author.first
author.books.out_of_print

chainable scopes
class Book < ApplicationRecord
        scope :out_of_print, -> { where(out_of_print: true) }
        scope :out_of_print_and_expensive, -> { out_of_print.where("price > 500") }
end

using conditionals
class Order < ApplicationRecord
    scope :created_before, ->(time) {where(created_at: ...time) if time.present?}
end

merge
class Book < ApplicationRecord
    default_scope { where(out_of_print: false) }
end

class Book < ApplicationRecord
    scope :in_print, -> { where(out_of_print: false) }
    scope :out_of_print, -> { where(out_of_print: true) }
  
    scope :recent, -> { where(year_published: 50.years.ago.year..) }
    scope :old, -> { where(year_published: ...50.years.ago.year) }
end

Book.in_print.merge(Book.out_of_print)

helfull for an interview 
Customer
  .select('customers.id, customers.last_name, reviews.body')
  .joins(:reviews)
  .where('reviews.created_at > ?', 1.week.ago)


find_or_create_by
Customer.find_or_create_by(first_name: 'Andy')

find_or_initialize_by
nina = Customer.find_or_initialize_by(first_name: 'Nina')

nina.save

pluck 
pluck can be used to pick the value(s) from the named column(s)
 in the current relation. 
irb> Book.where(out_of_print: true).pluck(:id)
SELECT id FROM books WHERE out_of_print = true
=> [1, 2, 3]

irb> Order.distinct.pluck(:status)
SELECT DISTINCT status FROM orders
=> ["shipped", "being_packed", "cancelled"]

irb> Customer.pluck(:id, :first_name)
SELECT customers.id, customers.first_name FROM customers
=> [[1, "David"], [2, "Fran"], [3, "Jose"]]

Order.joins(:customer, :books).pluck("orders.created_at, customers.email, books.title")


diff between save and save!

