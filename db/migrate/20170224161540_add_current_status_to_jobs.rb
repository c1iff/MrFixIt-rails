class AddCurrentStatusToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :current_status, :boolean, default: false
  end
end
