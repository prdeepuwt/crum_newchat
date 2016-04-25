class ConversationPolicy < ApplicationPolicy
  def update?
    is_owner? && record.kind == 'channel' #|| is_admin?
  end

end
