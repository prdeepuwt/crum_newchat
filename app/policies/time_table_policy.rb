class TimeTablePolicy < ApplicationPolicy
  def show?
    record.privacy == 'open' or is_owner?
  end
end
