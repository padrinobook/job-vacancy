require 'spec_helper'

RSpec.describe "/password_forget" do
  describe "GET /password_forget" do
    it 'renders new page' do
      get 'password_forget'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Forget Password'
    end
  end

  describe "POST /password_forget/create" do
    describe "user is not found" do
      it 'it renders the success page' do
        expect(User).to receive(:find_by_email)
          .and_return(nil)
        post '/password_forget/create', :email => ''
        expect(last_response).to be_ok
        expect(last_response.body).to include 'Password was reseted successfully'
      end
    end

    describe "user is found" do
      it 'it send the password reset mail and render the success page' do
        expectedLink = 'http://localhost:3000/password_forget/123/edit'
        expectedUser = double(User, :name => 'Red Dead Redemption', :email => 'hallo@padrino.de', :password_reset_token => '123')

        user_password_reset_mail = double(UserPasswordResetMail)
        expect(user_password_reset_mail).to receive(:reset_mail)
          .with(expectedLink)

        expect(UserPasswordResetMail).to receive(:new)
          .with(expectedUser)
          .and_return(user_password_reset_mail)

        expect(expectedUser).to receive(:save_forget_password_token)
          .and_return(nil)

        expect(User).to receive(:find_by_email).with('hallo@padrino.de')
          .and_return(expectedUser)

        post '/password_forget/create', :email => 'hallo@padrino.de'
        expect(last_response).to be_ok
        expect(last_response.body).to include 'Password was reseted successfully'
      end
    end
  end

  describe "GET /password_forget/:token/edit" do
    let(:user) { build_stubbed(:user) }
    let(:test_time) { Time.now.utc }

    context "password reset date is not older than one hour" do
      it 'renders edit page' do
        allow(Time).to receive(:now)
          .and_return(test_time)

        user.password_reset_sent_date = test_time + 60 * 60
        expect(User).to receive(:find_by_password_reset_token)
          .with('1')
          .and_return(user)
        get '/password_forget/1/edit'
        expect(last_response).to be_ok
        expect(last_response.body).to include 'Reset Password'
      end
    end

    context "password reset date is older than one hour" do
      it 'redirects to new session' do
        allow(Time).to receive(:now).and_return(test_time)

        user.password_reset_sent_date = test_time - 60 * 60
        expect(User).to receive(:find_by_password_reset_token)
          .with('1')
          .and_return(user)
        expect(user).to receive(:update_attributes)
          .with({ password_reset_token: 0, password_reset_sent_date: 0 })

        get '/password_forget/1/edit'

        expect(last_response).to be_redirect
        expect(last_response.body).to include 'Password reset token has expired.'
      end
    end

    context "user is not found" do
      it 'redirects to /password_forget' do
        expect(User).to receive(:find_by_password_reset_token).and_return(nil)
        get '/password_forget/1/edit'
        expect(last_response).to be_redirect
      end
    end
  end

  describe "POST /password_forget/:token" do
    let(:user) { build_stubbed(:user) }

    context "user can be updated" do
      it "redirects to login" do
        expect(User).to receive(:find_by_password_reset_token)
          .with('1')
          .and_return(user)
        expect(user).to receive(:update)
          .exactly(2).times
          .and_return(true)
        post '/password_forget/1'
        expect(last_response).to be_redirect
        expect(last_response.body).to include 'Password has been reseted. Please login with your new password.'
      end
    end

    context "user can not be updated" do
      it "renders edit page" do
        expect(User).to receive(:find_by_password_reset_token)
          .with('1')
          .and_return(user)
        expect(user).to receive(:update)
          .and_return(false)
        post '/password_forget/1'
        expect(last_response).to be_ok
      end
    end
  end
end

