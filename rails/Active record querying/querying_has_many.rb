Querying has_many

class People < ApplicationRecord
    belongs_to :role
    belongs_to :location
end

class Role <  ApplicationRecord
    has_many :peoples
end

class Location < ApplicationRecord
    has_many :peoples
end

task 
find all distinct  locations with at least one person who belongs
to a billable role 

Location.joins(:people)

Location.joins(:people :role).where(roles: {billable: true}).distinct

------
new task
order those locations by region name , then by location name

class Location < ActiveRecord
     belongs_to :region
end

class Region < ActiveRecord
    has_many :locations
end

Location.joins(:regions).merge(Region.order(:name)).order(:name)

Location.from(Location.billiable,:locations)

