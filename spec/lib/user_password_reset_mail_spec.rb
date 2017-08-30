require 'spec_helper'

RSpec.describe UserPasswordResetMail do
  let(:user) { build(:user) }

  it 'sends the password reset mail' do
    link = 'i-forget-everything'
    expect(app).to receive(:deliver).with(:password_reset, :email, user, link)

    @user_password_forget_mail = UserPasswordResetMail.new(user, app)
    @user_password_forget_mail.reset_mail(link)
  end
end

