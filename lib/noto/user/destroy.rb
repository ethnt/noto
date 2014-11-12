class UserDestroy < NotoMutation
  required do
    model :current_user, class: User
    hash :user do
      string :id
    end
  end

  def execute
    u = User.find(user['id'])

    unless current_user.can_destroy?(u)
      unauthorized!
    end

    u.destroy

    nil
  end
end
