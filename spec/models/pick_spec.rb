require 'rails_helper'

RSpec.describe Pick, type: :model do
  it 'is valid with url, image, title, body' do
    pick = FactoryBot.build(:pick)
    expect(pick).to be_valid
  end

  it 'is invalid without url' do
    pick = FactoryBot.build(:pick, url: nil)
    pick.valid?
    expect(pick.errors[:url]).to include("を入力してください")
  end

  it 'is invalid without image' do
    pick = FactoryBot.build(:pick, image: nil)
    pick.valid?
    expect(pick.errors[:image]).to include("を入力してください")
  end

  it 'is invalid without title' do
    pick = FactoryBot.build(:pick, title: nil)
    pick.valid?
    expect(pick.errors[:title]).to include("を入力してください")
  end

  it 'is invalid without body' do
    pick = FactoryBot.build(:pick, body: nil)
    pick.valid?
    expect(pick.errors[:body]).to include("を入力してください")
  end
end
