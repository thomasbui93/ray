# frozen_string_literal: true

class Owner::User::Remove < BaseService
  def initialize(user_id)
    @user_id = user_id
  end

  def execute
    user = Owner::User.find(@user_id)
    user.destroy!
  end
end
