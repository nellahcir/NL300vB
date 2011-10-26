class CreateTimedcps < ActiveRecord::Migration
  def self.up
    create_table :timedcps do |t|
      t.integer :checkpoint_id
      t.integer :startInterval
      t.integer :minMakeup

      t.timestamps
    end
  end

  def self.down
    drop_table :timedcps
  end
end
