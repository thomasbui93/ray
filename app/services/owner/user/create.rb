# frozen_string_literal: true

require 'attributes/merge'

class Owner::User::Create < BaseService
  def initialize(user_detail)
    @user_detail = user_detail
  end

  def execute
    user = Attributes::Merge.assign_parameter(Owner::User.new, @user_detail)
    user.save!
    user
  end
end
