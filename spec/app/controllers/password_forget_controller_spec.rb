require 'spec_helper'

RSpec.describe "PasswordForgetController" do
  describe "GET password_forget" do
    it "renders new page" do
      get 'password_forget'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Forget Password'
    end
  end

  describe "POST create" do
    it "renders success even if user was not found" do
      expect(User).to receive(:find_by_email).and_return(nil)
      post '/password_forget/create'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Password was reseted successfully'
    end
  end
end

