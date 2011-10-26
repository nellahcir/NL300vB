class CreateCheckouts < ActiveRecord::Migration
  def self.up
    create_table :checkouts do |t|
      t.integer :musher_id
      t.integer :checkpoint_id
      t.integer :dogs
      t.datetime :time

      t.timestamps
    end
  end

  def self.down
    drop_table :checkouts
  end
end
