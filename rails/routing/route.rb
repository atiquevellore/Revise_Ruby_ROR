

## ✅ Rails Routing Guide

### 🛣️ **What is Routing?**

Routing in Rails directs **incoming HTTP requests** to the appropriate **controller actions**.

---

### 🔁 **Non-RESTful Route**

```ruby
get '/posts', to: 'posts#index'
```

* Custom route manually mapped to `PostsController#index`.

---

### 🔄 **RESTful Routes**

#### 1. **Collection Resource (Plural - ID-based)**

```ruby
resources :books
```

**Generates:**

```
GET    /books          → books#index
GET    /books/:id      → books#show
POST   /books          → books#create
PATCH  /books/:id      → books#update
DELETE /books/:id      → books#destroy
```

---

#### 2. **Singleton Resource (Singular - No ID)**

```ruby
resource :book, except: [:show, :edit]
```

**Generates:**

```
GET    /book/new       → books#new
POST   /book           → books#create
PATCH  /book           → books#update
DELETE /book           → books#destroy
```

Use this when there is **only one resource per context**, like a profile, dashboard, or cart.

---

#### 3. **Selected RESTful Actions**

```ruby
resources :authors, only: [:index, :show]
```

**Generates:**

```
GET    /authors        → authors#index
GET    /authors/:id    → authors#show
```

---

### 🧭 **Namespace Routing**

```ruby
namespace :admin do
  resources :posts
end
```

**Generates routes like:**

```
GET /admin/posts       → Admin::PostsController#index
```

**✅ Use when:** organizing code into areas like admin dashboard or API versions.

---

### 🌿 **Nested Routing**

```ruby
resources :posts do
  resources :comments
end
```

**Generates:**

```
GET /posts/:post_id/comments → comments#index
```

**✅ Use when:** a resource logically **belongs to another** (e.g., comments belong to posts).

---

### 👥 **Collection vs Member Routes**

#### ✅ Collection Route

```ruby
resources :homes do
  collection do
    get  :post
    post :comment
  end
end
```

* **No ID required**
* Custom actions apply to the **whole collection**
* Routes:

  ```
  GET  /homes/post     → homes#post
  POST /homes/comment  → homes#comment
  ```

---

#### ✅ Member Route

```ruby
resources :homes do
  member do
    get  :post
    post :comment
  end
end
```

* **ID is required**
* Routes:

  ```
  GET  /homes/:id/post     → homes#post
  POST /homes/:id/comment  → homes#comment
  ```

---

### 📸 **Examples:**

#### 1. `/photos/:id/preview` (requires ID → member route)

```ruby
resources :photos do
  get 'preview', on: :member
end
```

#### 2. `/photos/search` (no ID → collection route)

```ruby
resources :photos do
  get 'search', on: :collection
end
```

---

### 🚧 **Routing to a Custom Path**

```ruby
get '/customer/profile', to: 'customers#profile'
```

You can also name it:

```ruby
get '/customer/profile', to: 'customers#profile', as: :customer_profile
```

Now you can use `customer_profile_path` or `customer_profile_url` in views/helpers.

---

Let me know if you'd like a diagram, a practice quiz, or real-world project structure for these routes!
