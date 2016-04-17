class AddCommentToAttatchments < ActiveRecord::Migration[5.0]
  def change
    add_column :attatchments, :comment, :text
  end
end
