routing is used to route   the incoming  request route to specified controller action

#non restful api routes
get '/posts'  to: 'post#index'

restful api routes

resources :books

resource :books, except: [:show,:edit]
resource :author, only: [:index,:show]  


namespace routing

namespace :admin do
    resource  :posts 
end

nested routing
resource :posts do
 resource :comments
end


Use Namespace Routing 
when you want to separate different areas of your app, like an admin dashboard, API, or different versions of an API.
Use Nested Routing when one resource logically belongs to another resource (e.g., comments belonging to a post, or orders belonging to a user).

member route vs collection route

Collection
collection used to define custom route when there no unique field required

GET '/homes/post'


resource :homes do
    get :post, on: :collection, to: 'homes#post', as: :post_homes
end

for defining multiple routes


resource :homes do
    collection do
        get  :post
        post :comment
    end
end

Member route define custom route but requires  a  unique field like id
get 'homes/:id/post' to: 'homes#post'

resources :homes do
    get :post, on: :member
end

resources :homes do
    member do
        get :pmeost
        post  :comment 
    end
end

example: /phots/preview
resource :photos do
    get 'preview', on: :member , to: ''
end

/photos/search
resource :photos do
    get 'search'
end