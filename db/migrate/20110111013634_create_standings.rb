class CreateStandings < ActiveRecord::Migration
  def self.up
    create_table :standings do |t|
      t.string :a

      t.timestamps
    end
  end

  def self.down
    drop_table :standings
  end
end
