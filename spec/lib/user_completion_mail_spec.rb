require 'spec_helper'

RSpec.describe UserCompletionMail do
  describe "user new record" do
    let(:user) { build(:user) }

    it 'encrypts the confirmation code of the user' do
      salt = '$2a$10$y0Stx1HaYV.sZHuxYLb25.'
      expected_confirmation_token = '$2a$10$y0Stx1HaYV.sZHuxYLb25.zAi0tu1C5N.oKMoPT6NbjtD.3cg7Au'
      expect(BCrypt::Engine).to receive(:generate_salt).and_return(salt)
      expect(BCrypt::Engine).to receive(:hash_secret).with(user.password, salt).and_return(expected_confirmation_token)
      @user_completion_mail = UserCompletionMail.new(user, app)
      @user_completion_mail.encrypt_confirmation_token

      expect(@user_completion_mail.user.confirmation_token).to eq expected_confirmation_token
    end

    it 'sends registration mail' do
      expect(app).to receive(:deliver).with(:registration, :registration_email, user.name, user.email)

      @user_completion_mail = UserCompletionMail.new(user, app)
      @user_completion_mail.send_registration_mail
    end

    it 'sends confirmation mail' do
      expect(app).to receive(:deliver).with(:confirmation, :confirmation_email, user.name, user.email, user.id, user.confirmation_token)

      @user_completion_mail = UserCompletionMail.new(user, app)
      @user_completion_mail.send_confirmation_mail
    end
  end
end

