require 'spec_helper'

RSpec.describe "/page" do
  %w(/ /about /contact).each do |path|
    describe "GET #{path}" do
      it "render the :#{path} view" do
        get path
        expect(last_response).to be_ok
      end
    end
  end
end
