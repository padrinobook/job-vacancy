require 'spec_helper'

describe "UsersController" do

  describe "GET login" do
    it "render the :new view" do
      get :login
      last_response.should be_ok
    end
  end

  describe "GET confirm" do
  let(:user) { build(:user) }
    it "render the 'users/confirm' page if user has confirmation code" do
      user.save
      get "/confirm/#{user.id}/#{user.confirmation_code.to_s}"
      last_response.should be_ok
    end

    it "redirect the :confirm if user id is wrong" do
      get "/confirm/test/#{user.confirmation_code.to_s}"
      last_response.should be_redirect
    end

    it "redirect to :confirm if confirmation id is wrong" do
      get "/confirm/#{user.id}/test"
      last_response.should be_redirect
    end
  end

end
