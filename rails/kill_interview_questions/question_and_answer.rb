
1. what is ORM in rails
 ORM stands for Object Relational Mapping
 ORM is technique that connects the rich objects of programming language with tables in RDBMS
 Basically Ruby Objects, Relational Objects can be easily stored and retrived into the database without writing sql queries
 
 2. what is Migration in rails
   Migration is feature of Active Record that allows to evolve database schema over time

3. what is Rake
   rake is an in built automation tool written in ruby . rake is used to define and manage taks that can be run through command line
   example rake is used to run database migrations, tests
4. what is Ruby on Rails 
   Ruby on Rails is a web application framework written in ruby
   Rails follow MVC architecture 
   Model Respresent the data and bussiness logic of the app
   View represents the presentation layer where the client interacts with it
   Controller  Manages the application flow and user interactions.it process the user interaction , updates the model , renders appropriate view to the user

5 what is Active Record in Ruby on Rails
   Active Record is the M in MVC architecture which is responsible for data layer and business logic
   Active Record helps to create and use Ruby object which requires persistent to the database

6  Role of Controller it manages the application flow and user iteraction 
   it process the user interaction such as network API calls, form action and manipulates the model and renders the appropriate view
   Controller also routes path to specific actions

7. require and load difference 
   require loads a file once, ideal for libraries and application code
   load a ruby file to used to reload the ruby script file it can used during
   development where we need to load a file instead of restarting the server

8. how types relationship does a model have
   1. one to one relationship
   2. one to many relationship
   3. many to many relationship

9. gem and plugin
   gem is ruby code it can be installed and used across application 
   plugin  is ruby code it can be installed and used by  single project

10. types of association does a model have
    1. belongs_to
    2. has_many
    3. has_one
    4. has_one through
    5. has_many through
    6. has_and_belongs_to_many

belongs_to
it is Basically 1:1 relationship it basically child or dependent on other model

class Book < ApplicationRecord
    belongs_to :author
end

has_many
it is 1:many relationship 

class Author < ApplicationRecord
    has_many  :books
end

has_one
it is a 1:1 relationship
class Supplier < ApplicationRecord
      has_one :account
end

has_one through
when relationship with extra model needs to be enchried with an additonal atrributes
class Supplier < ApplicationRecord
    has_one :account_history , through: :account
end

class Account < ApplicationRecord
     has_one :account
end

Class AccountHistory < ApplicationRecord
      belongs_to :account
end

has_many through
many to many relationship through another model
when relationship with extra model needs to be enchried with an additonal atrributes

example physicans and patients  where join model appointment provides appointment date,time and notes
class Physicians < ApplicationRecord
     has_many :appointments 
     has_many :patients , through: :appointments
end

class Appointments < ApplicationRecord
      belongs_to :physicians
      belongs_to :patients
end

class Patients < ApplicationRecord
    has_many :appointments 
     has_many :physcians , through: :appointments
end

has_and_belongs_to_many
many to many relationship 
when you need many to many without additonal attributes
class Assembly < Appplications
    has_and_belongs_to_many :parts
end

class Part < ApplicationRecord
    has_and_belongs_to_many :assemblies
end

rails migration can do 
create_table
create_table :table_name do |t|
    t.integer :column_name
    t.timestamps
end

drop table

add colum 

def change
    rename_column :usrers, :email
end

limits of ror
performance
memory usage
learning curve
switching to new version

Key Differences gem and library
Packaging and Distribution: Gems are a formalized way of packaging and distributing Ruby code, including version management and metadata. Libraries are more informal and may be shared or included directly without packaging.
Installation: Gems are installed through RubyGems or Bundler, whereas libraries might be manually included in a project.
Version Management: Gems come with versioning and dependency management features, while libraries typically require manual management of versions and dependencies.


class UserObserver < ActiveRecord::Observer
    def after_save(user)
      user.update_activity_log
    end
  
    def after_create(user)
      UserMailer.welcome_email(user).deliver_now
    end
  end

  class User < ApplicationRecord
    before_save :normalize_name
    after_create :send_welcome_email
  
    private
  
    def normalize_name
      self.name = name.downcase.titleize
    end
  
    def send_welcome_email
      UserMailer.welcome_email(self).deliver_now
    end
  end


  In summary, HashWithIndifferentAccess is useful when you need to access keys without worrying about their type, making it particularly convenient in Rails applications. Standard Ruby Hash, on the other hand, is straightforward and performs better when key types are consistently used.

  
