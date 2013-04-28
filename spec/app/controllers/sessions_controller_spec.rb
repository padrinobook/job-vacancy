require 'spec_helper'

describe "SessionsController" do

  describe "GET :new" do
    it "load the login page" do
      get "/login"
      last_response.should be_ok
    end
  end

  describe "POST :create" do
    let(:user) { build(:user)}
    let(:params) { attributes_for(:user)}

    it "stay on page if user is not found" do
      User.should_receive(:find_by_email).and_return(false)
      post_create(user.attributes)
      last_response.should be_ok
    end

    it "stay on login page if user is not confirmed" do
      user.confirmation = false
      User.should_receive(:find_by_email).and_return(user)
      post_create(user.attributes)
      last_response.should be_ok
    end

    it "stay on login page if user has wrong email" do
      user.email = "fake@google.de"
      User.should_receive(:find_by_email).and_return(user)
      post_create(user.attributes)
      last_response.should be_ok
    end

    it "stay on login page if user has wrong password" do
      user.password = "test"
      User.should_receive(:find_by_email).and_return(user)
      post_create(user.attributes)
      last_response.should be_ok
    end

    it "redirect if user is correct" do
      user.confirmation = true
      User.should_receive(:find_by_email).and_return(user)
      post_create(user.attributes)
      last_response.should be_redirect
    end
  end

  describe "DELETE :logout" do
    it "empty the current session"
    it "redirect to homepage if user is logging out"
  end

  private
  def post_create(params)
    post "sessions/create", params
  end
end
