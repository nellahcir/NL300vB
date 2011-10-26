class CreateCheckins < ActiveRecord::Migration
  def self.up
    create_table :checkins do |t|
      t.integer :musher_id
      t.integer :checkpoint_id
      t.integer :dogs
      t.datetime :time

      t.timestamps
    end
  end

  def self.down
    drop_table :checkins
  end
end
