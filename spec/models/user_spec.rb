# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:wishes) }
    it { is_expected.to have_many(:friends) }
    it { is_expected.to have_many(:friend_users) }
  end

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

  describe 'validation: account_id' do
    subject { create(:user) }

    it { is_expected.to validate_presence_of(:account_id) }
    it { is_expected.to validate_length_of(:account_id).is_at_most(255) }
    it { is_expected.to validate_uniqueness_of(:account_id) }
  end
end
