namespace :bootstrap do
  
  desc "add admin user"
  task :default_user => :environment do
    User.create( 
      :name => "admin", 
      :hashed_password => "de0316f95ec83efaaccaf9fc5e1a0bee3a8d12e6", # enaj1c22
      :salt => "21820279400.955187884251051", 
      :access_level => "admin", 
      :email => "admin@nellahcir.com")
  end
  
  desc "Run all bootstrapping tasks"
  task :all => [:default_user]
  
end