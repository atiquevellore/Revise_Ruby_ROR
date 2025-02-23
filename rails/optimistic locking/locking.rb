optimistic locking allows multiple users access the same record for edits and assume minimum of conflicts with the data

Active record supports optimisitic locking if the locking_version integer column field  is present

p1 = Person.find(1)
p2 = Person.find(1)

p1.first_name  = "Atique"
p1.save #update the lock_version integer column

p2.first_name = "Bokhari"
p2.save #rasie ActiveRecordStableObjectError

to overide name of the lock_version column

class Person < ActiveRecord::Base
    self.locking_column = :lock_person
end

Pessimistic Locking is technique used handle multiple concurrent updating a same resource


when Pessimistic lock is applied to a resource , other user are blocked accesing the resource until the lock is released
this ensures the only one user can update the resource 


two ways of implementing pessimistic locking
1. lock method
2. with_lock method

example
Seat.transaction do
    seat = Seat.lock.find(seat_id)

    if seat.booked
        raise "seat has been already booked"
    else
        seat.booked = true
        seat.booked_by = user_id
        seat.save!
    end
end



seat = seat.find(seat_id)

seat.with_lock do
    if seat.booked
        raise "seat has been already booked"
    else
        seat.booked = true
        seat.booked_by = user_id
        seat.save!
    end
end



lock:

Used directly within a transaction block.
Requires manual transaction management.
Provides more control over when and how the lock is applied.
with_lock:

Automatically wraps the block in a transaction and applies the lock.
Simplifies code by handling transaction management internally.
Preferred when you want to ensure a record is locked for a specific set of operations without manually managing the transaction.



pessimistic locking is used when the risks of conflicts are high and data is frequently updated by concurent process
optimistic locking when conflicts are rare 

