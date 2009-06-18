namespace :db do
  namespace :populate do
    desc "Populate the users table with 1000 random users"
    task :users => :environment do 
      require 'populator'
      require 'faker'

      # Destroy existing data
      User.destroy_all

      # Repopulate
      User.populate(1000) do |user|
        user.first_name = Faker::Name.first_name
        user.last_name = Faker::Name.last_name
        user.email_address = Faker::Internet.email
        user.status = rand(5) + 1
        user.admin = (rand(10) < 5 ? true : false)
      end
    end
  end
end
