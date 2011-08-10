namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_leagues
    make_entries
  end
end

def make_users
  admin = User.create!(:name => "Tyler Johnson",
                       :email => "tylerl.johnson@gmail.com",
                       :password => "foobar",
                       :password_confirmation => "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(:name => name,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_leagues
  league = League.create!(:name => "Pigskin Pickem",
                          :password => "foobar",
                          :admin_id => 1)
  99.times do |n|
    name = "league-#{n+1}"
    password = "password"
    League.create!(:name => name,
                   :password => password,
                   :admin_id => 2)
  end
end

def make_entries  
  100.times do |n|
    name = "entry-#{n+1}"
    Entry.create!(:league_id => 1,
                  :user_id => n+1,
                  :name => name)
  end
end