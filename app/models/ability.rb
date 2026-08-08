# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    if user.admin?
      can :manage, :all
    else
      can :manage, :all
      cannot :manage, Bibliotecario
    end
  end
end
