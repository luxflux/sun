class RelateMetricToPort < ActiveRecord::Migration
  def change
    remove_column :metrics, :location_id, :integer, index: true
    remove_column :metrics, :name, :string
    add_column :metrics, :port_id, :integer, index: true
  end
end
