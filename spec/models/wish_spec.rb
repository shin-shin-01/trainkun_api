# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Wish, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:images) }
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

  describe 'default_scope: order(star: :desc)' do
    let!(:wish_one) { create(:wish, star: 1) }
    let!(:wish_two) { create(:wish, star: 2) }
    let!(:wish_three) { create(:wish, star: 3) }

    it 'order(star: :desc)' do
      wishes = Wish.all
      expect(wishes[0].id).to eq wish_three.id
      expect(wishes[1].id).to eq wish_two.id
      expect(wishes[2].id).to eq wish_one.id
    end
  end

  describe 'default_scope: where(deleted: false)' do
    let!(:deleted_wish) { create(:wish, deleted: true) }
    let!(:not_deleted_wish) { create(:wish, deleted: false) }

    it 'where(deleted: false)' do
      wishes = Wish.all
      expect(wishes.size).to eq 1
      expect(wishes[0].id).to eq not_deleted_wish.id
    end
  end
end
