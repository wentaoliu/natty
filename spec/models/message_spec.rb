require 'rails_helper'

describe Message do

  it "has a valid factory" do
    expect(build(:message)).to be_valid
  end

  it { is_expected.to be_timestamped_document }
  it { is_expected.to be_paranoid_document }
  it { is_expected.to belong_to(:user).of_type(User) }

  it { is_expected.to validate_presence_of :content }

end
