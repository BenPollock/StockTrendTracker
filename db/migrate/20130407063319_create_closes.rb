class CreateCloses < ActiveRecord::Migration
  def change
    create_table :closes do |t|
      t.date :date
      t.float :open
      t.float :high
      t.float :low
      t.float :close
      t.decimal :volume

      t.timestamps
    end
  end
end
