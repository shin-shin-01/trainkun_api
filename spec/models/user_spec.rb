# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  before { skip_token_authorization }

  describe 'validation: name' do
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'validation: uid' do
    subject { create(:user) }

    it { is_expected.to validate_presence_of(:uid) }
    it { is_expected.to validate_length_of(:uid).is_at_most(255) }
    it { is_expected.to validate_uniqueness_of(:uid) }
  end
end
