require 'spec_helper'

RSpec.describe "PasswordForgetController" do
  describe "GET password_forget" do
    it "renders new page" do
      get 'password_forget'
      expect(last_response).to be_ok
      expect(last_response.body).to include 'Forget Password'
    end
  end
end

