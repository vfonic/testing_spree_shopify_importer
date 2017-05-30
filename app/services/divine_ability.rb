class DivineAbility
  include CanCan::Ability

  def initialize(_)
    can :manage, :all
  end
end
