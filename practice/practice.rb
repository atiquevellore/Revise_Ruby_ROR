
Associations(relationship between the models)

types of Associations
1. belongs_to
2.has_many
3.has_one
4.has_many through
5. has_one through
6. has_and_belongs_to_many

1. belongs_to
it is an dependent association like Car dependent on the CarShowrooms

example (Car table contains the showroom_id as the FK)
class Car < ApplicationRecord
    belongs_to :showroom
end

2. has_many (one to many relationship )

class Car < ApplicationRecord
    belongs_to :showroom
end

class ShowRoom < ApplicationRecord
      has_many :cars
end

3. has_one (one to one relationship)
class Person < ApplicationRecord
    has_one  :pan_card
end

class PanCard < ApplicationRecord
    belongs_to :person
end

4. has_many through(many to many association through an another model)

example
class Patient < ApplicationRecord
    has_many :appointments
    has_many :physicians, through: :appointments
end

class Appointment < ApplicationRecord
    belongs_to :physicians
    belongs_to :patients
end

class physicians < ApplicationRecord
      has_many :appointments
      has_many :patients , through: :appointments
end

5. has_one  through(one to one association through an another model)

example
class Supplier < ApplicationRecord
    has_one :account 
    has_one :account_histroy, through: :account
end

class Account < ApplicationRecord
      belongs_to :account
      has_one :account_histroy
end

class AccountHistory < ApplicationRecord
      belongs_to :account
end

class AccountHistory < ApplicationRecord
end

6. has_and_belongs_to_many (many to many association)

class Assemblies < ApplicationRecord
      has_and_belongs_to_many :parts
end

class Parts < ApplicationRecord
    has_and_belongs_to_many :assemblies
end

Polymorphic Associations(  a model belongs to one or model through an single association)

example
class Comment < ApplicationRecord
     belongs_to :commentable, polymorphic: true
end




class VideoPost < ApplicationRecord
    has_many :comments, as: :commentable
end

class PicturePost < ApplicationRecord
      has_many :comments, as: :commentable
end

difference between
has_and_belongs_to_many gives you a simple lookup table which references your two models.

has_many :through gives you a third model which can be used to store various other pieces of information which dont belong to either of the original models.


Active Record Querying

p1 = Person.find(10) finds with the primary key 

take retrives the record 
c1 = Customer.take(3)

first method retrive first record as per primary key order 
c1 = Customer.first(3) retrives first 3 records

last method retrives last three records
c3 = Customer.last(3)

retriving multiple objects in batches 
find_each

Customer.find_each do |customer|
    Newsmailer.deliver(customer).weekly
end


where
Book.where(roles: {billable: true})

placeholder where
Book.where("title=?",params[:title])

like
Book.where("title=?", Book.sanitise_sql_like(params[:title]) + %)

Order
Book.order(:created_at)

desc 
Book.order(:created_at :desc)

select specific fields 
Book.select(:name,:author)

joining two tables
Book.joins(:author)

scopes 


class Book < ApplicationRecord
    scope :out_of_print ,  -> {where(out_of_print: true)}
end

author  = Author.first
author.books.out_of_print

Dynamic finders
rails provides inbuilt method find_by_attribute_name

example find_by_first_name!(exclamation mark raises ARNF error)

N+1 query 

example 
books = Book.limit(10) (1 query)

books.each do |book|
    puts book.author.first_name
end (10 queries)

to fix the above we need to load the associations in advance 

using includes (eager loading)

books = Book.includes(:author).limit(10) 1query 

books.each do |book|
    puts book.author.first_name
end 1 query

preload is similar to includes it is not possible  specifying
conditions on preload

eager_load loads the Associations using LEFT OUTER JOIN

strict_loading(no lazy loaded)

user = User.strict_loading.first

optimistic locking
allows multiple users are trying to update  same records

in order to used optimistic locking we need have locking_version column
each time record is updated the locking_version is updated 
if an update request is made with an lower value of locking_version than
the current value of locking_version then it fails and 
raises ActiveRecordStaleObjectError

c1 = Customer.find(1)
c2 = Customer.find(1)

c1.first_name = "bob"
c1.save

c2.first_name = "atique"
c2.save #ARSOE

Pessimistic locking prevents 