require 'spec_helper'

describe NoteCreate do
  let(:user) { create :user }

  let(:action) do
    NoteCreate.run(
      current_user: user,
      note: {
        title: 'Untitled'
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of Note }
  it { expect(action.result.title).to eql 'Untitled' }
  it { expect(action.result.user).to eql user }
end
