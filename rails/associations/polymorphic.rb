#polymorphic 

#with polymorphic association, a model can belong to one or another model on  a single association


#comment table has  both 'commentable_id'  and 'commentable_type'
class Comment < ApplicationRecord
    belongs_to :commentable, polymorphic: true
end

class PicturePost < ApplicationRecord
    has_many :comments , as: :commentable
end

class VideoPost < ApplicationRecord
    has_many :comments , as: :commentable
end 

Yes, Rails handles the assignment of commentable_type and commentable_id automatically when working with polymorphic associations