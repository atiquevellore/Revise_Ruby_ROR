
A Rails migration is way to alter the database schema over time in a consistent and easy way

Basic commands

rails g migration migrationfilename


example:-
rails g migration AddAgeToUsers age:integer

run migration command rails db:migrate
rollback last migration rails db:rollback
bin/rails db:rollback STEP=3

#create a new table

rails g migration createProducts name:string part_number:string

#adding a new column to existing table
rails g migration AddPartNumberToProducts part_number:string

#adding multiple columns
rails g migration AddDetailsToproducts part_number:string  price:decimal

#removing column
rails g migration RemovePartNumberFromProducts part_number:string

#creating association migration
rails g migration AddUserRefToProducts user:references

rails g migration AddUserRedToProducts user:belongs_to

create join table
rails g migration createJoinTableUserProduct user product


manual migration inside the File
create_table :products do  |t|
    t.string :name
    t.references :category
    t.references :taggable, polymorphic: true
end

primary keys
create_table :users, primary_key: [:id,:name] do |t|
    t.string :name
    t.string :email
    t.timestamps
end

creating a join table
create_join_table :products ,:categories


change_table :products do |t|
    t.remove :description , :name
end

# The up method should describe the transformation 
# you'd like to make to your schema, and the down
#  method of your migration should revert the 
#  transformations done by the up method. 
#  In other words, the database schema 
#  should be unchanged if you do an up followed by a down.

class ChangeProductsPrice < ActiveRecord::Migration[7.2]
  def up
    change_table :products do |t|
      t.change :price, :string
    end
  end

  def down
    change_table :products do |t|
      t.change :price, :integer
    end
  end
end


reversible migration

class AddDummyRecords < ActiveRecord::Migration[6.1]
    def change
        reversible do |dir|
           dir.up do 
            "runs on rails db:migrate"
           end

           dir.down do
            "runs on rake db:rollback"
           end
        end
    end
end