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

    it "redirect the :confirm if user id is wrong" do
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

    it "redirects if wrong id" do
      get "/users/-1/edit"
      last_response.should be_redirect
    end

    it "render the view for editing a user" do
      User.should_receive(:find_by_id).twice.and_return(user)
      get "/users/#{user.id}/edit"
      last_response.should be_ok
    end
  end

  describe "PUT update" do
    let(:user) { build(:user) }
    it "does update attributes" do
      name_before = user.name
      new_name = Time.now.to_s
      id = user.id
      user.save
      params = user.attributes.merge({"name" => new_name, "created_at" => Time.now, "updated_at" => Time.now})
      put "users/#{user.id}", :user => params
      user = User.find(id)
      user.name.should_not be_eql(name_before)
    end
  end
end
