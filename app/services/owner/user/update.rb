# frozen_string_literal: true

require 'attributes/merge'

class Owner::User::Update < BaseService
  def initialize(params)
    @user_id = params[:id]
    @user_data = params
  end

  def execute
    user = Attributes::Merge.assign_parameter(Owner::User.find(@user_id), @user_data)
    user.save!
    user
  end
end
