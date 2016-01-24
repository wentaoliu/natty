require 'rails_helper'

describe Topic do

  it "has a valid factory" do
    expect(build(:topic)).to be_valid
  end

  it { is_expected.to be_timestamped_document }
  it { is_expected.to be_paranoid_document }
  it { is_expected.to belong_to(:user).of_type(User) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_length_of(:content).greater_than(50) }
  it { is_expected.to have_field(:hits).of_type(Integer).with_default_value_of(0) }
  it { is_expected.to have_field(:hidden).of_type(Mongoid::Boolean).with_default_value_of(false) }

end
