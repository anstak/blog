namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    admin = User.create!(name: "Anton Borzenko",
                 email: "anstak@gmail.com",
                 password: "001137",
                 password_confirmation: "001137")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@example.org"
      password  = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    users = User.all(limit: 10)
    2.times do
      name = Faker::Lorem.sentence(5)
      content = Faker::Lorem.sentence(200)
      users.each { |user| user.posts.create!(name: name, content: content) }
    end

    posts = Post.all(limit: 5)
    10.times do
      content = Faker::Lorem.sentence(30)
      posts.each do |post|
        comment = post.comments.build(content: content)
        comment.user_id = rand(4)
        comment.save
      end
    end

    words = %w{html5 css javascript web-design prototype stanford pool arrays}
    5.times do |n|
      Post.all.each do |post|
        word = words[rand(7)]
        tag = post.tags.build(name: word)
        if post.tags.find_by_name(word) == nil
          if tag.valid?
            post.tags.create!(name: word)
          else
            post.relationships.create!(tag_id: Tag.find_by_name(word).id, post_id: post.id)
          end
        end
      end
    end
  end
end
