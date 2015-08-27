require 'spec_helper'

RSpec.describe "SessionsController" do
  describe "GET :new" do
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
      User.should_receive(:find_by_email).and_return(user)
      post 'sessions/create', {:password => 'correct'}
      expect(last_response).to be_ok
    end

    it "redirects to home if password is correct and has no remember_me check" do
      user.confirmation = true
      user.password = "real"
      expect(User).to receive(:find_by_email).and_return(user)
      post 'sessions/create', {:password => 'real', :remember_me => false}
      expect(last_response).to be_redirect
    end
#
#     it "stay on login page if user has wrong password" do
#       user.password = "test"
#       User.should_receive(:find_by_email).and_return(user)
#       post_create(user.attributes)
#       last_response.should be_ok
#     end
#
#     it "redirect if user is correct" do
#       user.confirmation = true
#       User.should_receive(:find_by_email).and_return(user)
#       post_create(user.attributes)
#       last_response.should be_redirect
#     end
  end

  describe "GET :logout" do
    it "empty the current session" do
      get_logout
      expect(session[:current_user]).to be_nil
      expect(last_response).to be_redirect
    end

    it "redirect to homepage if user is logging out" do
      get_logout
      expect(last_response).to be_redirect
    end
  end

  private
  def post_create(params)
    post "sessions/create", params
  end

  def get_logout
      # first arguments are params (like the ones out of an form), the second are environments variables
    get '/logout', { :name => 'Hans', :password => 'Test123' }, 'rack.session' => { :current_user => 1 }
  end
end
