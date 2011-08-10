class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :league_id
      t.integer :user_id
      t.string :name

      t.timestamps
    end
    add_index :entries, :league_id
    add_index :entries, :user_id
    add_index :entries, [:league_id, :name], :unique => true
  end

  def self.down
    drop_table :entries
  end
end
