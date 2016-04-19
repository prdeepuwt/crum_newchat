class CreateTagsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :tags_users do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :tag, foreign_key: true
    end
  end
end
