require 'spec_helper'

describe "PageController" do

  describe "GET #about" do

    it "renders the :about view" do
      get '/about'
      last_response.should be_ok
    end
  end

  describe "GET #contact" do

    it "renders the :contact view" do
      get '/contact'
      last_response.should be_ok
    end
  end

  describe "GET #home" do
    it "renders :home view" do
      get '/'
      last_response.should be_ok
    end
  end

end
