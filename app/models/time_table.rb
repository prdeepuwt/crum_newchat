class TimeTable < ApplicationRecord
  belongs_to :user
  enum privacy:{ open: 0, hidden: 1 }
end
