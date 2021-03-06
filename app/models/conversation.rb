class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :users
  belongs_to :user
  enum kind:{ channel: 0, direct: 1 }
  validates :name, presence: true
end
