class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Bucketlist, user_id: user.id
    can :manage, Item do |item|
      item.bucketlist.user_id == user.id
    end
  end
end
