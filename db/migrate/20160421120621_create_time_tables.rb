class CreateTimeTables < ActiveRecord::Migration[5.0]
  def change
    create_table :time_tables do |t|
      t.string :title
      t.string :description
      t.datetime :start
      t.datetime :end
      t.integer :privacy
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
