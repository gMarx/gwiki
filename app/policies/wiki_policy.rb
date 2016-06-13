class WikiPolicy < ApplicationPolicy
  def update?
    record.present? && (record.user == user || !record.private? )
  end

  def edit?
    # allow all users to edit any wiki (they can see)
    record.present?
  end

  def view?
    # see public wikis & private ones created by self
    record.present? && (record.user == user || record.user.role == :admin || record.private? == false)
  end

  def destroy?
    # only allow a user (or admin) to destroy their own wiki(s)
    record.present? && (record.user == user || record.user.role == :admin)
  end
end
