class AddIsPublicToDiaries < ActiveRecord::Migration[8.0]
  def change
    add_column :diaries, :is_public, :boolean, default: false, null: false
  end
end
