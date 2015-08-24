require 'spec_helper'

describe "SessionsController" do

  describe "GET :new" do
    it "load the login page" do
      get "/login"
      expect(last_response).to be_ok
    end
  end

  describe "POST :create" do
    it "I'm to stupid to test POST + UPDATE request"
#     let(:user) { build(:user)}
#     let(:params) { attributes_for(:user)}
#
#     it "stay on page if user is not found" do
#       User.should_receive(:find_by_email).and_return(false)
#       post_create(user.attributes)
#       last_response.should be_ok
#     end
#
#     it "stay on login page if user is not confirmed" do
#       user.confirmation = false
#       User.should_receive(:find_by_email).and_return(user)
#       post_create(user.attributes)
#       last_response.should be_ok
#     end
#
#     it "stay on login page if user has wrong email" do
#       user.email = "fake@google.de"
#       User.should_receive(:find_by_email).and_return(user)
#       post_create(user.attributes)
#       last_response.should be_ok
#     end
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
