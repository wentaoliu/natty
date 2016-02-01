require 'rails_helper'

describe Instrument do

  it "has a valid factory" do
    expect(build(:instrument)).to be_valid
  end

  it { is_expected.to be_timestamped_document }
  it { is_expected.to belong_to(:user).of_type(User) }

  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :content }
  it { is_expected.to have_field(:maintainer).of_type(BSON::ObjectId) }
  it { is_expected.to have_field(:hidden).of_type(Mongoid::Boolean).with_default_value_of(false) }

end
