require 'spec_helper'

RSpec.describe "PasswordForgetController" do
  describe "GET /password_forget" do
    it "renders new page" do
      get 'password_forget'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Forget Password'
    end
  end

  describe "POST /password_forget/create" do
    let(:user) { build(:user)}

    it "renders success even if user was not found" do
      expect(User).to receive(:find_by_email).and_return(nil)
      post '/password_forget/create'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Password was reseted successfully'
    end

    it "renders success even if user was found" do
      expect(User).to receive(:find_by_email).and_return(user)
      post '/password_forget/create'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Password was reseted successfully'
    end
  end

  describe "GET /password-reset/:token/edit" do
    let(:user) { build(:user) }

    it "renders edit page from password-forget" do
      user.password_reset_sent_date = 1.minutes.before(1.hour.ago)
      expect(User).to receive(:find_by_password_reset_token).and_return(user)
      get '/password-reset/1/edit'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Reset Password'
    end

    it "redirects to new session because password reset timestamp was over one hour ago", :current do
      user.password_reset_sent_date = 1.minute.ago
      expect(User).to receive(:find_by_password_reset_token).and_return(user)
      expect(user).to receive(:update_attributes)
      get '/password-reset/1/edit'
      expect(last_response).to be_redirect
      expect(last_response.body).to include 'Password reset token has expired.'
    end

    it "redirects to /password_forget if user is not found" do
      expect(User).to receive(:find_by_password_reset_token).and_return(nil)
      get '/password-reset/1/edit'
      expect(last_response).to be_redirect
    end
  end
end

