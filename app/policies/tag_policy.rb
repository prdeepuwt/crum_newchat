class TagPolicy < ApplicationPolicy
  def is_owner?
    logged_in? && (record.users.include?(users))
  end
  def update?
    false #|| is_admin?
  end
end
