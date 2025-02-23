

#sets up a many_to_many relationship through another model

class Physicians < ApplicationRecord
    has_many :appointments
    has_many :patients, through: :appointments
end

#appointment table would have physiciamn_id,patient_id (FK) 
class Appointemnets < ApplicationRecord
    belongs_to :physicians
    belongs_to :patients
end

class Patients < ApplicationRecord
    has_many :appointments
    has_many :physicians, through: :appointments
end