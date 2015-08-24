require 'spec_helper'

describe SessionsHelper do
  before do
    class SessionsHelperKlass
      include SessionsHelper
    end

    @session_helper = SessionsHelperKlass.new
  end

  context "#current_user" do
    it "output the current user if current user is already set" do
      user = User.new
      @session_helper.current_user = user
      expect(@session_helper.current_user).to eq user
    end

    it "find the user by id from the current session" do
      user = User.first
      browser = Rack::Test::Session.new(JobVacancy::App)
      browser.get '/', {}, 'rack.session' => { :current_user => user.id }
      @session_helper.should_receive(:last_request).and_return(browser.last_request)
      expect(@session_helper.current_user).to eq user
    end
  end

  context "#current_user?" do
    it "returns true if current user is logged in" do
      user = User.new
      @session_helper.should_receive(:current_user).and_return(user)
      expect(@session_helper.current_user?(user)).to be_truthy
    end

    it "returns false if user is not logged in" do
      user = User.new
      @session_helper.should_receive(:current_user).and_return(nil)
      expect(@session_helper.current_user?(user)).to be_falsey
    end
  end

  context "#sign_in" do
    it "it sets the current user to the signed in user" do
      user = User.first
      browser = Rack::Test::Session.new(JobVacancy::App)
      browser.get '/', {}, 'rack.session' => { :current_user => user.id }
      @session_helper.should_receive(:session).and_return(browser.last_request)
      @session_helper.sign_in(user)
      expect(@session_helper.current_user).to eq user
    end
  end

  context "#signed_in?" do
    it "return false if user is not logged in" do
      @session_helper.should_receive(:current_user).and_return(nil)
      expect(@session_helper.signed_in?).to be_falsey
    end

    it "return true if user is logged in" do
      @session_helper.should_receive(:current_user).and_return(User.new)
      expect(@session_helper.signed_in?).to be_truthy
    end
  end
end
