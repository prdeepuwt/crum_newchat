class CreateConversationsUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :conversations_users do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :conversation, foreign_key: true
    end
  end
end
