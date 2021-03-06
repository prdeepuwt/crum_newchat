class CreateBookmarks < ActiveRecord::Migration[5.0]
  def change
    create_table :bookmarks do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :message, foreign_key: true

      t.timestamps
    end
  end
end
