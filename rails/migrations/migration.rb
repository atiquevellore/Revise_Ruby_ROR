# ✅ Ruby on Rails Migrations Guide

Migrations in Rails allow you to **alter the database schema over time** in a consistent and version-controlled way.

---

## 🛠️ Basic Migration Commands

| Command                             | Purpose                                                        |
| ----------------------------------- | -------------------------------------------------------------- |
| `rails g migration <Name>`          | Generate a new migration file                                  |
| `rails db:migrate`                  | Apply **all pending** migrations to the database               |
| `rails db:prepare`                  | Create DB if needed, load schema, and apply pending migrations |
| `rails db:rollback`                 | Undo the last migration                                        |
| `rails db:rollback STEP=n`          | Rollback the last `n` migrations                               |
| `rails db:migrate:down VERSION=...` | Rollback a **specific** migration by version ID                |

---

## 📦 Examples of Migration Generators

### ➕ Add Column to Existing Table

```bash
rails g migration AddAgeToUsers age:integer
```

### 🆕 Create a New Table

```bash
rails g migration CreateProducts name:string part_number:string
```

### ➕ Add Multiple Columns

```bash
rails g migration AddDetailsToProducts part_number:string price:decimal
```

### ➖ Remove a Column

```bash
rails g migration RemovePartNumberFromProducts part_number:string
```

### 🔗 Create Associations

```bash
rails g migration AddUserRefToProducts user:references
rails g migration AddUserRefToProducts user:belongs_to
```

### 🔀 Create a Join Table

```bash
rails g migration CreateJoinTableUserProduct user product
```

---

## 🧾 Manual Schema Definitions in Migrations

### 📄 Creating a Table with References

```ruby
create_table :products do |t|
  t.string     :name
  t.references :category
  t.references :taggable, polymorphic: true
end
```

### 🆔 Composite Primary Keys

```ruby
create_table :users, primary_key: [:id, :name] do |t|
  t.string :email
  t.timestamps
end
```

### 🔁 Join Table via DSL

```ruby
create_join_table :products, :categories
```

### 🛠 Modify Existing Table

```ruby
change_table :products do |t|
  t.remove :description, :name
end
```

---

## 🔄 Reversible Migrations

### 🧠 Definition:

A **reversible migration** is one that Rails can **automatically reverse** when you run `rails db:rollback`. 
This is the default behavior when using the `change` method, as long as the operations are reversible (e.g., `add_column`, `create_table`, etc.).

### ✅ Example:

```ruby
class AddDummyRecords < ActiveRecord::Migration[6.1]
  def change
    reversible do |dir|
      dir.up do
        # Runs on `rails db:migrate`
      end

      dir.down do
        # Runs on `rails db:rollback`
      end
    end
  end
end
```

---

## ❌ Irreversible Migrations

### 🧠 Definition:

An **irreversible migration** is a migration that **cannot be undone automatically**, 
typically because it performs destructive or raw SQL operations. If you try to rollback such a migration
 and haven’t defined `down`, Rails will raise an error.

### ⚠️ Example:

```ruby
class DoSomethingDangerous < ActiveRecord::Migration[7.0]
  def up
    execute "UPDATE customers SET status = 'active'"
  end

  def down
    execute "UPDATE customers SET status = NULL"
  end
end
```

If the `down` method were **missing**, this migration would be **irreversible**.

---

## 🔁 Up / Down Migrations (Manual Reversibility)

Use `up` and `down` methods when you want **complete control** over what happens during migration and rollback.

```ruby
class ChangeProductsPrice < ActiveRecord::Migration[7.2]
  def up
    change_table :products do |t|
      t.change :price, :string
    end
  end

  def down
    change_table :products do |t|
      t.change :price, :integer
    end
  end
end
```

---

## 🧠 Summary

* Use `rails g migration` to generate migration files.
* Use `change` for most migrations (auto reversible).
* Use `up`/`down` for **manual control**.
* Use `reversible` for **conditional behavior** in change blocks.
* Mark a migration as **irreversible** by skipping the `down` method or using destructive operations.
