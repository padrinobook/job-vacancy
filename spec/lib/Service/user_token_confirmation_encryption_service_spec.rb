require 'spec_helper'

RSpec.describe UserTokenConfirmationEncryptionService do
  describe "#encrypt_confirmation_token" do
    let(:user) { build(:user) }

    it 'encrypts the confirmation token of the user' do
      salt = '$2a$10$y0Stx1HaYV.sZHuxYLb25.'
      expected_confirmation_token = '$2a$10$y0Stx1HaYV.sZHuxYLb25.zAi0tu1C5N.oKMoPT6NbjtD.3cg7Au'
      expect(BCrypt::Engine).to receive(:generate_salt)
        .and_return(salt)
      expect(BCrypt::Engine).to receive(:hash_secret)
        .with(user.password, salt)
        .and_return(expected_confirmation_token)
      @service = UserTokenConfirmationEncryptionService.new(user)
      @service.encrypt_confirmation_token

      expect(@service.user.confirmation_token).to eq expected_confirmation_token
    end
  end
end

