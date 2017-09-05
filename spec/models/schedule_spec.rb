require 'rails_helper'

describe Schedule do

  it "has a valid factory" do
    expect(build(:schedule)).to be_valid
  end

  it { is_expected.to have_timestamps }
  it { is_expected.to belong_to(:user).of_type(User) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :starts_at }
  it { is_expected.to validate_presence_of :ends_at }
  it { is_expected.to have_field(:hidden).of_type(Mongoid::Boolean).with_default_value_of(false) }

end
