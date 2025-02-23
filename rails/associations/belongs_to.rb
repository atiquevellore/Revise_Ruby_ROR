    #belongs_to

    class Post < ApplicationRecord

        belongs_to  :User
        #association model name must be singular
        #it form 1:1 connection with an another model
        #this model is the child or dependent in the relationship
        #book table
        #title
        #author_id(FK)
        #Author table
        #id(PK)
    end