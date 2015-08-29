require 'spec_helper'

RSpec.describe "SessionsController" do
  describe "GET /login" do
    it "load the login page" do
      get "/login"
      expect(last_response).to be_ok
    end
  end

  describe "POST :create" do
    let(:user) { build(:user)}
    let(:params) { attributes_for(:user)}

    it "stay on page if user is not found" do
      expect(User).to receive(:find_by_email).and_return(false)
      post 'sessions/create'
      expect(last_response).to be_ok
    end

    it "stay on login page if user is not confirmed" do
      user.confirmation = false
      expect(User).to receive(:find_by_email).and_return(user)
      post 'sessions/create'
      expect(last_response).to be_ok
    end

    it "stay on login page if user has wrong password" do
      user.confirmation = true
      user.password = "fake"
      expect(User).to receive(:find_by_email).and_return(user)
      post 'sessions/create', {:password => 'correct'}
      expect(last_response).to be_ok
    end

    it "redirects to home if password is correct and has no remember_me check" do
      user.confirmation = true
      user.password = 'real'
      expect(User).to receive(:find_by_email).and_return(user)
      post 'sessions/create', {:password => 'real', :remember_me => false}
      expect(last_response).to be_redirect
    end

    it "redirect if user is correct and has remember_me" do
      token = 'real'
      user = double("User")
      expect(user).to receive(:id).and_return(1)
      expect(user).to receive(:password).and_return('real')
      expect(user).to receive(:confirmation).and_return(true)
      expect(user).to receive(:authentity_token=).and_return(token)
      expect(user).to receive(:save)
      expect(User).to receive(:find_by_email).and_return(user)
      expect(SecureRandom).to receive(:hex).at_least(:once).and_return(token)

      post 'sessions/create', {:password => 'real', :remember_me => true}
      expect(last_response).to be_redirect
      cookie = last_response['Set-Cookie']
      expect(cookie).to include('permanent_cookie')
      expect(cookie).to include('path=/')
      expect(cookie).to include('domain%3D%3E%22jobvacancy.de')
      expect(cookie).to include('max-age=2592000')
    end
  end

  describe "GET /logout" do
    it "empty the current session" do
      get '/logout'
      expect(session[:current_user]).to be_nil
    end

    it "redirect to homepage if user is logging out" do
      get '/logout'
      expect(last_response).to be_redirect
    end
  end
end

