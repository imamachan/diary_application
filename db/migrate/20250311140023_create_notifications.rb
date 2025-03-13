class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :diary, null: false, foreign_key: true
      t.string :action
      t.boolean :read, default: false, null: false

      t.timestamps
    end
  end
end
