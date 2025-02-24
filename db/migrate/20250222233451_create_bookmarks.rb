class CreateBookmarks < ActiveRecord::Migration[8.0]
  def change
    create_table :bookmarks do |t|
      t.references :user, foreign_key: true
      t.references :diary, foreign_key: true

      t.timestamps
    end
    add_index :bookmarks, [ :user_id, :diary_id ], unique: true
   end
end
