
# Example:
#reate_by!(name: genre_name)
#   end

User.create(email: 'Admin@example.com',
            password: 'password',
            password_confirmation: 'password',
            name: 'Admin',
            role: User.roles[:admin])
User.create(email: 'john@gmail.com',
            password: 'password',
            password_confirmation: 'password',
            name: 'John Doe')

User.create(email: 'Alex@gmail.com',
            password: 'password',
            password_confirmation: 'password',
            name: 'Alex')

10.times do |x|
  post = Post.create(title: "Title #{x}",
                     body: "Body #{x} Words go here Idk",
                     user_id: User.first.id)

  5.times do |y|
    post.comments.create(body: "Comment #{y}",
                   user_id: User.second.id)
  end
end