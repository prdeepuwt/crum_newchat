class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  has_many :bookmarks
  has_many :users, through: :bookmarks
end
