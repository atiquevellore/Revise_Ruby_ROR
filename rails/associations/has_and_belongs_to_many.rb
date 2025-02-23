

#many to many relationship without intervetion


# need to create new join table named assemblies_parts which contains assembly_id and part_id
class Assembly < ApplicationRecord
    has_and_belongs_to_many :parts
end

class Part < ApplicationRecord
    has_and_belongs_to_many :assemblies
end