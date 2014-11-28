class NoteCreate < NotoMutation
  required do
    model :current_user, class: User
    hash :note do
      string :title
    end
  end

  def execute
    n = Note.new(note)
    n.user = current_user

    mongoid_errors!(n)

    n.save

    n
  end
end
