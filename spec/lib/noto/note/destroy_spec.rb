require 'spec_helper'

describe NoteDestroy do
  let(:note) { create :note }

  context 'authorized user' do
    let(:user) { note.user }

    let(:action) do
      NoteDestroy.run(
        current_user: user,
        note: {
          id: note.id.to_s,
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to eql nil }
  end

  context 'unauthorized user' do
    let(:other) { create :user }

    let(:action) do
      NoteDestroy.run(
        current_user: other,
        note: {
          id: note.id.to_s,
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
