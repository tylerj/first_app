class Entry < ActiveRecord::Base
  attr_accessor   :league_password
  attr_accessible :name, :user_id, :league_id
  
  belongs_to :user
  belongs_to :league
  
  def user
    User.find(user_id)
  end
end
