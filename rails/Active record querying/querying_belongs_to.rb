Querying belongs_to Association

example

Role has many people

class People < ApplicationRecord
    belongs_to :role
end

class Role <  ApplicationRecord
    has_many :peoples
end

People
-------
id (PK)
name
role_id(FK)


Role
-----
id 
name
billable(boolean)

People.all.joins(:role).where(roles: {billable: true})

Role.where(billable: true)

-------
another way of writing the above billable query

class Role < ApplicationRecord
    def self.billable
        where(billable :true)
    end
end

Role.billable
People.joins(:role).merge(Role.billable)

class People < ApplicationRecord
    def self.billiable
        joins(:role).merge(Role.billable)
    end
end

People.billable