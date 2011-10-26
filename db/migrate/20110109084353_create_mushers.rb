class CreateMushers < ActiveRecord::Migration
  def self.up
    create_table :mushers do |t|
      t.string :name
      t.integer :bibnum
      t.integer :dogs
      t.integer :year
      t.integer :stpos
      t.integer :status_id
      t.datetime :restartdiff

      t.timestamps
    end
  end

  def self.down
    drop_table :mushers
  end
end
