#n+1 problem example 

=begin
 n+1 problem
 1 query to fetch all the posts
 n queries to fetch all the comments associated with each post
 (11 posts, 11 queries to fetch all the comments)
=end

Eager loading is the process of retrieving 
associated records of a model in a single query, 
rather than executing separate queries for each associated record.

posts = Post.limit(10)


post.each do |post|
    puts post.comments.count
end

# eagrer loading 

posts = Post.includes(:comments).limit(10)
posts.each do |post|
    puts post.comments.count
end

=begin
 1 query to fetch all the posts
 1 query to fetch all the comments associated with each post
(11 posts, 2 query to fetch all the comments)
=end

work differently:

1. **`preload`** (Separate Queries)
  - Loads associated records in **separate queries**.
  - Does **not** use SQL joins.
  - Example:
    ```ruby
    # Fetch books and their authors (separate queries)
    books = Book.preload(:author).limit(5)
    books.each do |book|
     puts book.author.name
    end
    ```
  - Generates:
    ```sql
    SELECT * FROM books LIMIT 5;
    SELECT * FROM authors WHERE id IN (...);
    ```
  - Best when you **don’t need** to filter/order by associated records.

2. **`eager_load`** (Single Query with `JOIN`)
  - Uses **LEFT OUTER JOIN** to load everything in **one query**.
  - Example:
    ```ruby
    # Fetch books and their authors, and filter by author name (single query with JOIN)
    books = Book.eager_load(:author).where(authors: { name: "Alice" })
    books.each do |book|
     puts book.author.name
    end
    ```
  - Generates:
    ```sql
    SELECT books.*, authors.* FROM books LEFT OUTER JOIN authors ON books.author_id = authors.id WHERE authors.name = 'Alice';
    ```
  - Best when you **need** to filter/order by associated records.

3. **`includes`** (Hybrid Approach)
   - Rails **decides** whether to use `preload` (separate queries) or `eager_load` (JOIN) based on query conditions.
   - Example:
     ```ruby
     Book.includes(:author)
     ```
   - If filtering by `author.name`, Rails **switches to `eager_load`**.
   - Otherwise, it **defaults to `preload`**.

### Summary:
| Method       | Queries | Uses `JOIN`? | Best for |
|-------------|---------|-------------|----------|
| `preload`   | Multiple | No | Simple association loading |
| `eager_load` | Single  | Yes | Filtering/sorting by association |
| `includes`  | Adaptive | Sometimes | Flexible loading |

