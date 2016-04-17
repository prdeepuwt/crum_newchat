class CreateAttatchments < ActiveRecord::Migration[5.0]
  def change
    create_table :attatchments do |t|
      t.belongs_to :message, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end
