require 'spec_helper'

describe UserCreate do
  let(:action) do
    UserCreate.run(
      user: {
        email: 'billnye@pbs.org',
        username: 'billnye',
        password: 'sciencerules',
        password_confirmation: 'sciencerules'
      }
    )
  end

  it { expect(action.success?).to eql true }
  it { expect(action.result).to be_an_instance_of User }
  it { expect(action.result.email).to eql 'billnye@pbs.org' }
end
