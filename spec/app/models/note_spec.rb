require 'spec_helper'

describe Note do
  let(:note)  { create :note }
  let(:user)  { note.user }
  let(:other) { create :user }
  let(:admin) { create :user, :admin }

  it { expect(note).to be_valid }

  it { expect(note).to validate_presence_of :title }

  describe '#viewable_by?' do
    it { expect(note.viewable_by?(user)).to eql true }
    it { expect(note.viewable_by?(other)).to eql false }
    it { expect(note.viewable_by?(admin)).to eql true }
  end

  describe '#creatable_by?' do
    it { expect(note.creatable_by?(user)).to eql true }
    it { expect(note.creatable_by?(other)).to eql true }
    it { expect(note.creatable_by?(admin)).to eql true }
  end

  describe '#updatable_by?' do
    it { expect(note.updatable_by?(user)).to eql true }
    it { expect(note.updatable_by?(other)).to eql false }
    it { expect(note.updatable_by?(admin)).to eql true }
  end

  describe '#destroyable_by?' do
    it { expect(note.destroyable_by?(user)).to eql true }
    it { expect(note.destroyable_by?(other)).to eql false }
    it { expect(note.destroyable_by?(admin)).to eql true }
  end


  describe '#html!' do
    it { expect(note.html).to include '<p>The cosmos are a very large place. <em>Definitely</em> wouldn&#39;t want to walk there.</p>' }
  end

  describe '#permalink!' do
    it { expect(note.permalink).to include 'the-cosmos' }
  end
end
