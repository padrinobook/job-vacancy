require 'spec_helper'

describe SessionsHelper do
  before do
    class SessionsHelperKlass
      include SessionsHelper
    end

    @session_helper = SessionsHelperKlass.new
  end

  describe "#current_user" do
    it "output the current user if current user is already set" do
      user = User.new
      @session_helper.current_user = user
      expect(User).to receive(:find_by_id).never
      expect(@session_helper.current_user).to eq user
    end

    it "finds the user by id from the current session" do
      user = User.first
      browser = Rack::Test::Session.new(JobVacancy::App)
      browser.get '/', {}, 'rack.session' => { :current_user => user.id }
      expect(User).to receive(:find_by_id).and_return(user)
      expect(@session_helper).to receive(:last_request).and_return(browser.last_request)
      expect(@session_helper.current_user).to eq user
    end
  end

  describe "#current_user?" do
    it "returns true if current user is logged in" do
      user = User.new
      expect(@session_helper).to receive(:current_user).and_return(user)
      expect(@session_helper.current_user?(user)).to be_truthy
    end

    it "returns false if user is not logged in" do
      user = User.new
      expect(@session_helper).to receive(:current_user).and_return(false)
      expect(@session_helper.current_user?(user)).to be_falsey
    end
  end

  describe "#sign_in" do
    it "sets the current user to the signed in user" do
      user = User.first
      browser = Rack::Test::Session.new(JobVacancy::App)
      browser.get '/', {}, 'rack.session' => { :current_user => user.id }
      expect(@session_helper).to receive(:session).and_return(browser.last_request)
      @session_helper.sign_in(user)
      expect(@session_helper.current_user).to eq user
    end
  end

  describe "#sign_out" do
    it "clear the current_user from the session" do
      browser = Rack::Test::Session.new(JobVacancy::App)
      browser.get '/', {}, 'rack.session' => { :current_user => 1 }
      expect(@session_helper).to receive(:session).and_return(browser.last_request.env['rack.session'])
      @session_helper.sign_out
      expect(browser.last_request.env['rack.session']).not_to include('current_user')
    end
  end

  describe "#signed_in?" do
    it "return false if user is not logged in" do
      expect(@session_helper).to receive(:current_user).and_return(nil)
      expect(@session_helper.signed_in?).to be_falsey
    end

    it "return true if user is logged in" do
      expect(@session_helper).to receive(:current_user).and_return(User.new)
      expect(@session_helper.signed_in?).to be_truthy
    end
  end
end
