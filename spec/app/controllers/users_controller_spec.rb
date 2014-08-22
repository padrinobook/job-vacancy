require 'spec_helper'

describe "UsersController" do

  describe "GET new" do
    it "render the :new view" do
      get "/register"
      last_response.should be_ok
    end
  end

  describe "GET confirm" do
    let(:user) { build(:user) }
    it "render the '/confirm' page if user has confirmation code" do
      user.save
      user_confirmed = User.find_by_id(user.id)
      get "/confirm/#{user_confirmed.id}/#{user_confirmed.confirmation_code.to_s}"
      last_response.should be_ok
    end

    it "redirect to :confirm if user id is wrong" do
      get "/confirm/test/#{user.confirmation_code.to_s}"
      last_response.should be_redirect
    end

    it "redirect to :confirm if confirmation id is wrong" do
      get "/confirm/#{user.id}/test"
      last_response.should be_redirect
    end
  end

  describe "GET edit" do
    let(:user) { build(:user) }

    xit "render the view for editing a user" do
      User.should_receive(:find_by_id).at_least(:once).with(anything()).and_return(user)

      get "/users/#{user.id}/edit"
      # I come to this point but the last response is not okay but and routing error
      last_response.should be_ok
    end

    it "redirects if wrong id" do
      get "/users/-1/edit"
      last_response.should be_redirect
    end
  end

  describe "PUT update" do
    xit "redirects and update attributes"
  end
end
