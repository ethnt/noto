require 'spec_helper'

describe Note do
  let(:note) { create :note }
  let(:user) { note.user }

  it { expect(note).to be_valid }

  it { expect(note).to validate_presence_of :title }

  describe '#html!' do
    it { expect(note.html).to include '<p>The cosmos are a very large place. <em>Definitely</em> wouldn&#39;t want to walk there.</p>' }
  end

  describe '#permalink!' do
    it { expect(note.permalink).to include 'the-cosmos' }
  end
end
