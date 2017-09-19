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
      case user.permission
      when 1
        can :read, :all, :hidden => false
      when 2
        can [:read, :create], :all
      when 3
        can [:read, :create, :update], :all
      when 4
        can :manage, :all
      end
      can :manage, Schedule do |s|
        s.user = user
      end
      cannot :manage, User
    end
  end
end
