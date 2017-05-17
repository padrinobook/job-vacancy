require 'spec_helper'

RSpec.describe "JobVacancy::App::SessionsHelper" do
  let(:user) { User.new }
  let(:session_helper) { Class.new }

  before { session_helper.extend JobVacancy::App::SessionsHelper }
  subject { session_helper }

  describe "#current_user" do
    it 'returns the current user if user is set' do
      subject.current_user = user
      expect(User).to receive(:find_by_id).never
      expect(subject.current_user).to eq user
    end

    it 'returns the current user from session' do
      user.id = 1
      browser = Rack::Test::Session.new(app)
      browser.get '/', {}, 'rack.session' => { current_user: user.id }
      expect(User).to receive(:find_by_id).and_return(user)
      expect(subject).to receive(:session).and_return(user)
      expect(subject.current_user).to eq user
    end
  end

  describe "#current_user?" do
    it 'returns true if current user is logged in' do
      expect(subject).to receive(:current_user).and_return(user)
      expect(subject.current_user?(user)).to be_truthy
    end

    it 'returns false if user is not logged in' do
      expect(subject).to receive(:current_user).and_return(false)
      expect(subject.current_user?(user)).to be_falsey
    end
  end

  describe "#sign_in" do
    it 'sets the current user to the signed in user' do
      browser = Rack::Test::Session.new(app)
      browser.get '/', {}, 'rack.session' => { current_user: user.id }
      expect(subject).to receive(:session).and_return(browser.last_request)
      subject.sign_in(user)
      expect(subject.current_user).to eq user
    end
  end

  describe "#sign_out" do
    it 'clears the current_user from the session' do
      browser = Rack::Test::Session.new(app)
      browser.get '/', {}, 'rack.session' => { current_user: 1 }
      expect(subject).to receive(:session).and_return(browser.last_request.env['rack.session'])
      subject.sign_out
      expect(browser.last_request.env['rack.session']).not_to include('current_user')
    end
  end

  describe "#signed_in?" do
    it 'returns false if user is not logged in' do
      expect(subject).to receive(:current_user).and_return(nil)
      expect(subject.signed_in?).to be_falsey
    end

    it 'returns true if user is logged in' do
      expect(subject).to receive(:current_user).and_return(User.new)
      expect(subject.signed_in?).to be_truthy
    end
  end
end
