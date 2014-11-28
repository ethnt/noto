require 'spec_helper'

describe NoteUpdate do
  let(:note) { create :note }

  context 'authorized user' do
    let(:user) { note.user }

    let(:action) do
      NoteUpdate.run(
        current_user: user,
        note: {
          id: note.id.to_s,
          title: 'The Cosmos',
          text: 'The cosmos are a _large_ place.'
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to be_an_instance_of Note }
    it { expect(action.result.title).to eql 'The Cosmos' }
  end

  context 'unauthorized user' do
    let(:other) { create :user }

    let(:action) do
      NoteUpdate.run(
        current_user: other,
        note: {
          id: note.id.to_s,
          title: 'The Cosmos',
          text: 'The cosmos are a _large_ place.'
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
