require 'rails_helper'

describe User do

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it { is_expected.to have_timestamps }

  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username) }
  it { is_expected.to validate_length_of(:username).within(4..20) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }

end
