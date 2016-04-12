class WikiPolicy < ApplicationPolicy
  def update?
    record.present? && (record.user == user || record.public)
  end

  def destroy?
    record.present? && record.user == user
  end
end
