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
      test_time = Time.local(2015, "sep", 9, 7, 00, 00, 00).to_datetime
      expect(Time).to receive(:now).and_return(test_time,test_time,test_time,test_time,test_time,test_time,test_time)

      user.password_reset_sent_date = test_time + 1.0/24.0
      expect(User).to receive(:find_by_password_reset_token).and_return(user)
      get '/password-reset/1/edit'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Reset Password'
    end

    it "redirects to new session because password reset timestamp was over one hour ago" do
      test_time = Time.local(2015, "sep", 9, 7, 00, 00, 00).to_datetime
      expect(Time).to receive(:now).and_return(test_time,test_time,test_time)

      user.password_reset_sent_date = test_time - 1.0/24.0
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

  describe "POST /password-reset/:token" do
    let(:user) { build(:user) }

    it "renders edit page if user can be updated" do
      expect(User).to receive(:find_by_password_reset_token).and_return(user)
      expect(user).to receive(:update_attributes).and_return(true, true)
      post '/password-reset/1'
      expect(last_response).to be_redirect
      expect(last_response.body).to include 'Password has been reseted. Please login with your new password.'
    end

    it "renders edit page if user can not be updated" do
      expect(User).to receive(:find_by_password_reset_token).and_return(user)
      expect(user).to receive(:update_attributes).and_return(false)
      post '/password-reset/1'
      expect(last_response).to be_ok
    end
  end
end

