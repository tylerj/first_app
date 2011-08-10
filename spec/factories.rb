# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Example User"
  user.email                 "example@railstutorial.org"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :league do |league|
  league.name        "League Example"
  league.password    "password"
  league.association :entry
end