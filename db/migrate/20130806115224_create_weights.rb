class CreateWeights < ActiveRecord::Migration
  def up
    create_table :weights do |t|
      t.decimal :weight, :precision => 4, :scale => 1
      t.datetime :date
      t.timestamps
    end
  end

  def down
    drop_table :weights
  end
end
