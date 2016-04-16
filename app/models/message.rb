class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  def abc
    return "a"
  end
end
