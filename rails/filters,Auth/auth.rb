filters
filtering out unauthorized requests 

class PostsController < ApplicationController
    before_action  :require_login, only: [:edit,:updat]

    private
    def require_login
        if current_user.logged_in
        else
            redirect_to login_path
        end
    end
end

cookies 
cookies are key value data pairs that are stored in a browser until thye reach specified expiration time

rails provides hash cookies
cookies[:hair_color]= 'blonde'

Authentication vs authorization
regular user for authentication
admin user for authorization
jwt token authentication for Securing APIS

the process involves genrating token upon successful authentication
and validating that token on subsequent requests

gem 'jwt'

