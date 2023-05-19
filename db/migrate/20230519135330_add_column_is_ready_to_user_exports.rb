class AddColumnIsReadyToUserExports < ActiveRecord::Migration[7.0]
  def change
    add_column :user_exports, :is_ready, :boolean, default: false
  end
end
