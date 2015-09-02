require 'spec_helper'

RSpec.describe "UsersController" do
  describe "GET new" do
    it "render the :new view" do
      get "/register"
      expect(last_response).to be_ok
    end
  end

  describe "GET confirm" do
    let(:user) { build(:user) }
    it "render the '/confirm' page if user has confirmation code" do
      user.save
      user_confirmed = User.find_by_id(user.id)
      get "/confirm/#{user_confirmed.id}/#{user_confirmed.confirmation_code.to_s}"
      expect(last_response).to be_ok
    end

    it "redirect to :confirm if user id is wrong" do
      get "/confirm/test/#{user.confirmation_code.to_s}"
      expect(last_response).to be_redirect
    end

    it "redirect to :confirm if confirmation id is wrong" do
      get "/confirm/#{user.id}/test"
      expect(last_response).to be_redirect
    end
  end

  describe "GET /users/:id/edit" do
    let(:user) { build(:user) }
    let(:user_second) { build(:user) }

    it "redirects if user is not signed in" do
      get "/users/-1/edit", {}, { 'rack.session' => { current_user: nil}}
      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/login')
    end

    it "redirects if user is signed in and tries to call a different user" do
      expect(User).to receive(:find_by_id).and_return(user, user_second)
      get "/users/2/edit"
      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/login')
    end

    it "render the view for editing a user" do
      id = user.id
      expect(User).to receive(:find_by_id).and_return(user, user, user)
      get "/users/#{id}/edit", {}, { 'rack.session' => { current_user: id } }
      expect(last_response).to be_ok
    end
  end

  describe "PUT update" do
    xit "redirects and update attributes"
  end
end
