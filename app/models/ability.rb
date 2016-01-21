class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)
    if user.superadmin?
      can :manage, :all
    elsif user.admin?
      can :manage, :all
      cannot [:update, :destroy], User do |u|
        u.admin? and u.username != user.username
      end
    else
      modules = [Achievement, Bulletin, Comment, Instrument, Meeting, News,
        Resource, Topic, Wiki, Inventory]
      for m in modules
        case user.merged_permission[m.to_s.downcase]
        when 1
          can :read, m, :hidden => false
        when 2
          can [:read, :create], m
        when 3
          can [:read, :create, :update], m
        when 4
          can :manage, m
        end
      end
      can :manage, Schedule do |s|
        s.user = user
      end
    end
  end
end
