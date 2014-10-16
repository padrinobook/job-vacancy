require 'spec_helper'

describe "PageController" do

  %w(/ /about /contact).each do |path|
    describe "GET #{path}" do
      it "render the :#{path} view" do
        get path
        last_response.should be_ok
      end
    end
  end
end
