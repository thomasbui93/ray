# frozen_string_literal: true

class Owner::UserService
  def get_or_create(user_data)
    user = user_data.is_a?(Owner::User) ? Owner::User.new(user_data) : Owner::User.find(user_data)
    raise ArgumentError, 'User not found with given id' unless user

    user
  end

  def clean_up(users)
    users.each do |user|
      user.destroy! if user.memberships.empty?
    end
  end
end
