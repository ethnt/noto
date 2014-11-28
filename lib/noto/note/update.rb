class NoteUpdate < NotoMutation
  required do
    model :current_user, class: User
    hash :note do
      string :id
      string :title
      string :text
    end
  end

  def execute
    n = Note.find(note['id'])

    unless current_user.can_update?(n)
      unauthorized!
    end

    n.update_attributes(note)

    mongoid_errors!(n)

    n.save

    n
  end
end
