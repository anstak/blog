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
      name = Faker::Lorem.sentence(3)
      content = Faker::Lorem.sentence(100)
      users.each { |user| user.posts.create!(name: name, content: content) }
    end
  end
end
