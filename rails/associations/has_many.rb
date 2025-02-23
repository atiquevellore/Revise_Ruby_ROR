
class Author < ApplicationRecord
    has_many :books

    #association model name must be plurual
    # form one to many associations
    # books are associated with an foreign hey
    
end