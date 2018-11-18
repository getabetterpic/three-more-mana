require 'rails_helper'

RSpec.describe MtgSet, type: :model do
  subject { FactoryBot.build(:mtg_set) }
  it { is_expected.to validate_presence_of(:code) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:code).case_insensitive }
end
