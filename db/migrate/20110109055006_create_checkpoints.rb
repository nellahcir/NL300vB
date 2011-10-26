class CreateCheckpoints < ActiveRecord::Migration
  def self.up
    create_table :checkpoints do |t|
      t.string :name
      t.integer :sequence
      t.integer :milepost

      t.timestamps
    end
  end

  def self.down
    drop_table :checkpoints
  end
end
