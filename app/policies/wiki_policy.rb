class WikiPolicy < ApplicationPolicy
  def update?
    record.present? && (record.user == user || !record.private? )
  end

  def show?
    # see public wikis & private ones created by self
    record.present? && (record.user == user || record.user.role == :admin || record.private? == false)
  end

  def destroy?
    # only allow a user (or admin) to destroy their own wiki(s)
    record.present? && (record.user == user || record.user.role == :admin)
  end
end
