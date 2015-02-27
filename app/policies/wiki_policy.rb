class WikiPolicy < ApplicationPolicy
  class Scope
     attr_reader :user, :scope
 
     def initialize(user, scope)
       @user = user
       @scope = scope
     end
 
     def resolve
       wikis = []
       if user.nil?
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.private == nil
             wikis << wiki # if the user is not logged in, only show them public wikis
           end
         end
       elsif user.role == "admin"
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif user.role == "premium"
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.private == nil || wiki.user == user || wiki.collaborating_users.include?(user)
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end
       else # this is the lowly standard user
         all_wikis = scope.all
         wikis = []
         all_wikis.each do |wiki|
           if wiki.private == nil || wiki.collaborating_users.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
     end
  end

  def private?
    (user.role == "admin") || (user.role == "premium")
  end
end