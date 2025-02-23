
#sets one to one association through another model 


class Supplier < ApplicationRecord
     has_one :account
     has_one :account_history, through: :account
end


class Account < ApplicationRecord
    belongs_to :supplier
    has_one :account_history
end

class AccountHistory < ApplicationRecord
    belongs_to :account
end