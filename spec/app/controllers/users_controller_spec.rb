require 'spec_helper'

describe "UsersController" do

  %w(/login).each do |path|
    describe "GET #{path}" do
      it "render the :#{path} view" do
        get path
        last_response.should be_ok
      end
    end
  end
end
