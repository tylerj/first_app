class League < ActiveRecord::Base
  attr_accessible :name, :password, :admin_id
  
  has_many :entries
  
  validates :password, :presence => true,
                       :length => { :within => 4..40 }
  
  validates :admin_id, :presence => true
  
  default_scope :order => 'leagues.created_at DESC'
                       
  def in_league?(entrant)
    entries.find_by_user_id(entrant)
  end
  
  def create_new_entry(user)
    self.entries.build(:user_id => user, :name => default_entry_name(user))
  end
  
  def num_user_entries(user)
    Entry.where(:user_id => user, :league_id => self).count
  end
  
  def default_entry_name(user)
    entry_count = num_user_entries(user)
    entry_count > 0 ? "#{user.name}-#{entry_count + 1}" : user.name
  end  
  
  def admin
    User.find_by_id(self.admin_id)
  end
  
end
