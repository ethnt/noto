class UserUpdate < NotoMutation
  required do
    model :current_user, class: User
    hash :user do
      string :id
      string :email
      string :username
      string :password
      string :password_confirmation
    end
  end

  def execute
    u = User.find(user['id'])

    unless current_user.can_update?(u)
      unauthorized!
    end

    u.update_attributes(user)

    mongoid_errors!(u)

    u.save

    u
  end
end
