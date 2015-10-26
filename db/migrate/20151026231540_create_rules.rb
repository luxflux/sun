class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.references :input, references: :ports, index: true
      t.integer :rule
      t.integer :threshold
      t.references :output, references: :ports, index: true
      t.integer :state

      t.timestamps null: false
    end

    add_foreign_key :rules, :ports, column: :input_id
    add_foreign_key :rules, :ports, column: :output_id
  end
end
