class AddNotifierToNotifications < ActiveRecord::Migration[8.0]
  def change
    add_column :notifications, :notifier_id, :integer
    add_index :notifications, :notifier_id
  end
end
