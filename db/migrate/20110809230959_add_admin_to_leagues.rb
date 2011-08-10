class AddAdminToLeagues < ActiveRecord::Migration
  def self.up
    add_column :leagues, :admin_id, :integer
  end

  def self.down
    remove_column :leagues, :admin_id
  end
end
