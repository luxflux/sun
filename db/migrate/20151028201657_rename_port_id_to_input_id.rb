class RenamePortIdToInputId < ActiveRecord::Migration
  def change
    rename_column :metrics, :port_id, :input_id
  end
end
