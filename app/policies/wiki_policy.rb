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

  class Scope
     attr_reader :user, :scope

     def initialize(user, scope)
       @user = user
       @scope = scope
     end

     def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if !wiki.private? || wiki.user_id == user || wiki.collaborators.include?(user)
             wikis << wiki # if the user is premium, show them public wikis, any private wikis they created, and private wikis they are a collaborator on
           end
         end
       else # standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if !wiki.private? || wiki.collaborators.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
     end
   end
end
