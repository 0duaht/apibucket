class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, Bucketlist, user_id: user.id
    can :manage, Item do |item|
      bucketlist = Bucketlist.find(item.bucketlist_id)

      bucketlist.user_id == user.id
    end
  end
end
