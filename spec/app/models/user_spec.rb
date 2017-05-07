require 'spec_helper'

RSpec.describe "User Model" do
  let(:user) { build_stubbed(:user) }
  let(:user_second) { build_stubbed(:user) }

  it 'can be created' do
    expect(user).not_to be_nil
  end

  it 'fresh user should have no offers' do
    expect(user.job_offers.size).to eq 0
  end

  it 'has job-offers' do
    user.job_offers.build(attributes_for(:job_offer))
    expect(user.job_offers.size).to eq 1
  end

  it 'has no blank name' do
    user.name = ''
    expect(user.valid?).to be_falsey
  end

  it 'has no blank email' do
    user.email = ''
    expect(user.valid?).to be_falsey
  end

  describe "passwords" do
    let(:user_confirmation) { build(:user) }
    it 'no blank password' do
      user_confirmation.password = ''
      expect(user_confirmation.valid?).to be_falsey
    end

    it 'password length should be at least 5 characters long' do
      user_confirmation.password = 'octo'
      expect(user_confirmation.valid?).to be_falsey
    end
  end

  describe "name is already used" do
    it 'should not be saved' do
      User.destroy_all
      user = build(:user)
      user_second = build(:user)
      user.save
      user_second.name = user.name
      expect(user_second.valid?).to be_falsey
    end
  end

  describe "when email address is already used" do
    it 'should not save an user with an existing address' do
      user = build(:user)
      user_second = build(:user)
      user.save
      user_second.email = user.email
      user_second.save
      expect(user_second.valid?).to be_falsey
    end
  end

  describe 'email address' do
    it 'valid' do
      adresses = %w[thor@marvel.de hero@movie.com]
      adresses.each do |email|
        user.email = email
        user_second.email = email
        expect(user_second.valid?).to be_truthy
      end
    end

    it 'not valid' do
      adresses = %w[spamspamspam.de heman,test.com]
      adresses.each do |email|
        user_second.email = email
        expect(user_second.valid?).to be_falsey
      end
    end
  end

  describe 'confirmation code' do
    let(:confirmation_user) { build(:user) }

    it 'should authenticate user with correct confirmation code and should be confirmed' do
      confirmation_user.save
      confirmation_of_saved_user = User.find_by_id(confirmation_user.id)
      confirmation_user.confirmation_code = confirmation_of_saved_user.confirmation_code
      expect(confirmation_user.authenticate(confirmation_user.confirmation_code)).to be_truthy
      expect(confirmation_user.confirmation).to be_truthy
    end

    it 'should not authenticate user with incorrect confirmation code' do
      expect(confirmation_user.authenticate('wrong')).to be_falsey
    end
  end

  describe "#generate_authentity_token" do
    let(:confirmation_user) { build(:user) }

    it 'generates the authentity_token before user is saved' do
      expect(user).to receive(:save).and_return(true)
      user.send(:generate_authentity_token)
      user.save
      expect(user.authentity_token).not_to be_empty
    end
  end
end

