require 'spec_helper'

describe UserDestroy do
  let(:user) { create :user }

  context 'authorized user' do
    let(:action) do
      UserDestroy.run(
        current_user: user,
        user: {
          id: user.id.to_s,
        }
      )
    end

    it { expect(action.success?).to eql true }
    it { expect(action.result).to eql nil }
  end

  context 'unauthorized user' do
    let(:other) { create :user }

    let(:action) do
      UserDestroy.run(
        current_user: other,
        user: {
          id: user.id.to_s,
        }
      )
    end

    it { expect(action.success?).to eql false }
    it { expect(action.errors.symbolic).to eql ({ 'current_user' => :unauthorized }) }
  end
end
