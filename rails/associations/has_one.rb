class Supplier < ApplicationRecord

    has_one :account

    #only contains one instance of another model
    #account contains the supplier_id as the foregin key
    
    #rails generate model Supplier name:string
    #rails generate model Account account_number:string supplier:references
end