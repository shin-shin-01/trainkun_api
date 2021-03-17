# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:wish) }
  end

  describe 'validation: url' do
    it { is_expected.to validate_length_of(:url).is_at_most(255) }
    it { is_expected.to validate_presence_of(:url) }
  end
end
