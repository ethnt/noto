require 'spec_helper'

describe Note do
  let(:note) { create :note }
  let(:user) { note.user }

  it { expect(note).to be_valid }

  it { expect(note).to validate_presence_of :title }

  describe '#permalink!' do
    it { expect(note.permalink).to include 'the-cosmos' }
  end
end
