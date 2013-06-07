require 'spec_helper'

describe SessionsHelper do
  before do
    class SessionsHelperClass
      include SessionsHelper
    end

    @user = mock(User)
    @user.stub!(:find_by_id)

    @session_helper = SessionsHelperClass.new
  end

  context "current_user" do
    it "output the current user if current user is already set" do
      user = User.new
      @session_helper.current_user = user
      @session_helper.current_user.should == user
    end

    it "find the user by id from the current session" do
      @session_helper.current_user = nil
      user = User.first
      browser = Rack::Test::Session.new(Rack::MockSession.new(Sinatra::Application))
      browser.get '/', {}, 'rack.session' => { :current_user => user.id }
      @session_helper.should_receive(:last_request).and_return(browser.last_request)

      @session_helper.current_user.should == user

    end
  end

  context "current_user?" do
    it "returns true if current user is logged in"
    it "returns false if user is not logged in"
  end

  context " sign_in" do
    it "creates a session"
  end

  context " sign_out" do
    it "destroys the session"
  end

  context "#signed_in?" do
    it "return false if user is not logged in" do
    end

    it "return true if user is logged in"
  end
end
