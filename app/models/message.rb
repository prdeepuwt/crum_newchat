class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  has_many :bookmarks
  has_many :users, through: :bookmarks
  has_many :attatchments, dependent: :destroy
  accepts_nested_attributes_for :attatchments, reject_if: :all_blank
end
