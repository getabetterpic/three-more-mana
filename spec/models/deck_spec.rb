require 'rails_helper'

RSpec.describe Deck, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:cards) }
  it { is_expected.to validate_presence_of(:user) }
end
