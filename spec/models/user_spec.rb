require 'rails_helper'

RSpec.describe User, type: :model do
  subject { FactoryBot.build(:user) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to have_secure_password }
end
