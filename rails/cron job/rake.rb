desc "eat apple"

task :apple do
    puts "Eat more apples"
end

rake apple # to run the task


namespace common tasks under the hood

namespace :backup do
    task :create do
    end

    task :delete do
    end

    task :restore do
    end
end

to run namespace task
rake backup:create