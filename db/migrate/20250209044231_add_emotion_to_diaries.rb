class AddEmotionToDiaries < ActiveRecord::Migration[8.0]
  def change
    add_column :diaries, :emotion, :string
  end
end
