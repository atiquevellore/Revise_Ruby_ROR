
Active record callbacks are hooks that are triggred before or after licycle of  active record object


different types of callbacks
1. before callbacks
2. after callbacks
3. around callbacks
4. commit  callbacks


before_validation

before_validation :normalize_email

private
def normalize_email
    self.email = email.downcase.strip
end

before_save

before_create

before_update

before_destroy

after_create

after_update

after_destroy

diff between save and save!
save return true if the record is saved else returns false
save! return true if the record is saved else raise ARRI exception 

after_commit
after_save
after_rollback