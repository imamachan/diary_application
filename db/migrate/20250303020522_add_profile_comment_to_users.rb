class AddProfileCommentToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :profile_comment, :string
  end
end
