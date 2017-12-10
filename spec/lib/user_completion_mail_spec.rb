require 'spec_helper'

RSpec.describe UserCompletionMail do
  describe "user new record" do
    let(:user) { build_stubbed(:user) }

    it 'sends registration mail' do
      expect(app).to receive(:deliver).with(:registration, :registration_email, user.name, user.email)

      @user_completion_mail = UserCompletionMail.new(user, app)
      @user_completion_mail.send_registration_mail
    end

    it 'sends confirmation mail' do
      expect(app).to receive(:deliver)
        .with(:confirmation,
              :confirmation_email,
              user.name,
              user.email,
              user.id,
              user.confirmation_token)

      @user_completion_mail = UserCompletionMail.new(user, app)
      @user_completion_mail.send_confirmation_mail
    end
  end
end

