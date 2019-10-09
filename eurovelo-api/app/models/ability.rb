class Ability
  include CanCan::Ability

  def initialize(user)
    author_ids = User.where(role: "author").pluck(:id)
    
    user ||= User.new
    if user.has_role?
      can :read, :all
      can :my_posts, User
      if user.superadmin?
        can :manage, :all
      elsif user.localadmin?
        can :roles, User
        can :manage, User do |user_model|
          user_model.parent_id == user.id
        end
        can :manage, Place do |place|
          (place.user_id == user.id) || (author_ids.include? place.user_id)
        end
        can :manage, Alert do |alert|
          (alert.user_id == user.id) || (author_ids.include? alert.user_id)
        end
        can :manage, Trail do |trail|
          (trail.user_id == user.id) || (author_ids.include? trail.user_id)
        end
        can :update, User, id: user.id
      elsif user.author?
        can :roles, User
        can :manage, Place, user_id: user.id
        can :manage, Alert, user_id: user.id
        can :manage, Trail, user_id: user.id
        can :update, User, id: user.id
      end
    else
      can :read, Place
      can :read, Trail
      can :read, Alert
    end
    
    can :api_index, Place
  end
end
