student has many blogs
blog belong_to student

Blog.all.each do |blog|
    puts blog.student.email
end

1 query for fetching all the blogs
n qureries to fetch all the stduents email associated with blogs
n blogs (1 query fetch all blogs, will take n queries to fectch associated student blog record )

eager loading
-----

# Eager loading is the process whereby a query loads a resource as soon 
# as the code is executed .it also loads the  related entities(assocation) as part of the query
Blog.includes(:student).each do |blog|
    puts blog.student.email
end

Blog.preload(:student).each do |blog|
    puts blog.student.email
end

diff between preload and includes
where query only work on includes
@blogs = Blog.includes(:student).references(:student).where('students.first_name = ?', 'Ravi')

eager_load(Left outer join)
Blog.eager_load(:student).each do |blog|
    puts blog.student.email
end
