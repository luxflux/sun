class CreatePorts < ActiveRecord::Migration
  def change
    create_table :ports do |t|
      t.references :location, index: true, foreign_key: true
      t.string :type
      t.integer :number
      t.integer :signal_type
      t.string :name

      t.timestamps null: false
    end
  end
end
