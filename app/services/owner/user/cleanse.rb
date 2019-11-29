# frozen_string_literal: true

class Owner::User::Cleanse < BaseService
  def initialize(user)
    @user = user
  end

  def execute
    @user.destroy! if @user.memberships.empty?
  end
end
