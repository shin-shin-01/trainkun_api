
require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validation: name' do
    it { is_expected.to validate_length_of(:name).is_at_most(255)}
    it { is_expected.to validate_presence_of(:name)}
  end
end
