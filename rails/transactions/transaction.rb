Transaction are typically used when we need to ensure data integrity

Transactions are protective blocks
 where SQL statements are only permanent if they can all succeed as one atomic action. 

example

sender.debit_account(amount) if sender.sufficent_balance(amount)
credit_amount = convert_currency(amount,recipient)
perform_transfer(recipient,credit_amount,sender)

We need some way to ensure that errors along the way cause the database to roll back to avoid committing incomplete data. Either all of the database 
actions are performed, or none of them are.

Transfer.transaction do
    sender.debit_account(amount) if sender.sufficent_balance(amount)
    credit_amount = convert_currency(amount,recipient)
    perform_transfer(recipient,credit_amount,sender)
end

states of transaction
Active
PatiallyCommitted (changes not save to DB)
Committed (changed saved to DB)
Failed  (error occurred)
Aborted (db rolled back)

ActiveRecord Transaction

ActiveRecord::Base.transaction do
    sender.debit_account(amount) if sender.sufficent_balance(amount)
    credit_amount = convert_currency(amount,recipient)
    perform_transfer(recipient,credit_amount,sender)

end

Account.transaction do
    balance.save!
    account.save!
  end
If any kind of unhandled error happens inside the block, 
the transaction will be aborted, and no changes will be made to the DB.


abort transaction 

ActiveRecord::Base.transaction do
    @new_user = User.create!(user_params)
    @referrer = User.find(params[:referre_id])

    raise ActiveRecord::Rollback if @referrer.nil?
    
end

ActiveRecord::Base.Transaction do

    
end