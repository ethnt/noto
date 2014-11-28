class NoteDestroy < NotoMutation
  required do
    model :current_user, class: User
    hash :note do
      string :id
    end
  end

  def execute
    n = Note.find(note['id'])

    unless current_user.can_destroy?(n)
      unauthorized!
    end

    n.destroy

    nil
  end
end
