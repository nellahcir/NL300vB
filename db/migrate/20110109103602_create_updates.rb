class CreateUpdates < ActiveRecord::Migration
  def self.up
    create_table :updates do |t|
      t.integer :musher_id
      t.integer :checkpoint_id
      t.datetime :timein
      t.integer :dogsin
      t.datetime :timeout
      t.integer :dogsout

      t.timestamps
    end
  end

  def self.down
    drop_table :updates
  end
end
