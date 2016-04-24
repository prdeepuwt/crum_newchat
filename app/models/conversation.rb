class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_and_belongs_to_many :users
  enum kind:{ channel: 0, direct: 1 }
end
