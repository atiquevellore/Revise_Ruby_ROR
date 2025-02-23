
#Caching

Caching means to store content generated during request-response cycle and to reuse it while responding the similar resquests

Caching is the most effective way to boost application performance
through websites running a single server with a single database can sustain a load of thousands of concurrent users

Basic Caching
by default rails provides
1. fragment Caching

in order to used page and action caching we need have the following gems
1.actionpack-page_caching
2. actionpack-action_caching

to run caching locally use rails dev:cache command

page caching is a caching where response bodies are stored in files that the web server can serve directly

 A request -> E endpoint
 Response is calculated and stored in F
 next time E  is requested , the web server sends F quickly

 For example, content management systems like wikis 
 have typically many pages that are a great fit for
  this approach, but account-based systems where people log in and manipulate their own data are often less likely candidates.

class PostsController < ApplicationController
    caches_page :show
  
    def show
      @post = Post.find(params[:id])
    end
end

action caching

Fragment Caching
when different parts of the page need to be cached and expired separately you 
can use fragment caching

Fragment allows to wrap a fragment of view inside cache block

# <%  @products.each do |product| %>
#   <% cache product do %>
#     <%= render product %>
#     <% end %>
#   <% end %>


tell this in interview

Low Level Caching some time we need to cache a value or query result instead of view fragements

Efficent way to implement low level caching
Rails.cache.fetch

cache miss if key is missing from the cache then  block is executed and response is store in the cache under the given key
cache hit if the key value already exists the cache then cached value is returned instead of executing the block


def index
    @popular_posts = Rails.cache.fetch('popular_posts', expries_in: 1.hour) do
        Post.where('views > ?', 1000).order(views: :desc).limit(10)
    end
end

different types of cache store 
memory_store for small scale applications local memory of the rails application server  (cached data is not removed when server restarts)
memcachestore ideal for production environments (cached data is  removed when server restarts)
RedisCacheStore data can be retrived when server restarts


