class CreateActionLogEntries < ActiveRecord::Migration
  def change
    create_table :action_log_entries do |t|
      t.references :port, index: true, foreign_key: true
      t.string :state

      t.timestamps null: false
    end
  end
end
