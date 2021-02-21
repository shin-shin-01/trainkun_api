# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wish, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
  end

  describe 'validation: name' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
  end

  describe 'validation: star' do
    it { is_expected.to validate_presence_of(:star) }
    it { is_expected.to validate_numericality_of(:star).is_greater_than(0).is_less_than(6).only_integer }
  end

  describe 'validate: status' do
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to define_enum_for(:status).with_values(%i[wish bougth]) }
  end

  describe 'validate: deleted' do
    it { is_expected.to validate_presence_of(:deleted) }
    # boolean columns will automatically convert non-boolean values to boolean ones
    # it { is_expected.to validate_inclusion_of(:deleted).in_array([true, false]) }
  end
end
