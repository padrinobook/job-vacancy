require 'spec_helper'

RSpec.describe "/sessions" do
  describe "GET /login" do
    it 'loads the login page' do
      get '/login'
      expect(last_response).to be_ok
    end
  end

  describe "POST /sessions/create" do
    let(:user) { build_stubbed(:user) }
    let(:params) { attributes_for(:user) }

    it 'stays on login page if user is not found' do
      expect(User).to receive(:find_by_email) { false }
      post 'sessions/create'
      expect(last_response).to be_ok
    end

    it 'stays on login page if user is not confirmed' do
      user.confirmation = false
      expect(User).to receive(:find_by_email) { user }
      post 'sessions/create'
      expect(last_response).to be_ok
    end

    it 'stays on login page if user has wrong password' do
      user.confirmation = true
      user.password = 'correct'
      expect(User).to receive(:find_by_email) { user }
      post 'sessions/create', password: 'wrong'
      expect(last_response).to be_ok
    end

    it 'redirects to home for confirmed user and correct password' do
      login_user(user)
    end

    it 'redirects if user is correct and has remember_me' do
      token = 'real'
      user = double('User')
      thirty_days_in_seconds = JobVacancy::Configuration::COOKIE_MAX_AGE_REMEMBER_ME
      expect(user).to receive(:id) { 1 }
      expect(user).to receive(:password) { 'secret' }
      expect(user).to receive(:confirmation) { true }
      expect(user).to receive(:authentity_token=) { token }
      expect(user).to receive(:save)
      expect(User).to receive(:find_by_email) { user }
      expect(SecureRandom).to receive(:hex).at_least(:once) { token }

      post 'sessions/create', password: 'secret', remember_me: true

      expect(last_response).to be_redirect
      expect(last_response.body).to include('You have successfully logged in!')

      cookie = last_response['Set-Cookie']
      expect(cookie).to include('permanent_cookie')
      expect(cookie).to include('path=/')
      expect(cookie).to include('domain%3D%3E%22jobvacancy.de')
      expect(cookie).to include("max-age=#{thirty_days_in_seconds}")
    end
  end

  describe "DELETE /logout" do
    let(:user) { build_stubbed(:user) }

    it 'empty the current session' do
      login_user(user)
      delete '/logout'
      expect(last_request.env['rack.session'][:current_user]).to be_nil
    end

    it 'redirects to homepage if user is logging out' do
      delete '/logout'
      expect(last_response).to be_redirect
      expect(last_response.body).to include('You have successfully logged out.')
    end
  end
end


private
def login_user(user)
  user.confirmation = true
  user.password = 'correct'
  expect(User).to receive(:find_by_email) { user }
  post 'sessions/create', password: 'correct'
  expect(last_request.env['rack.session'][:current_user]).not_to be_nil
end

