require 'spec_helper'

RSpec.describe "/job_offers" do
  describe "GET list" do
    it "render the :list view" do
      get "/job_offers/list"
      expect(last_response).to be_ok
    end
  end

  describe "POST /job_offers/create" do
    let(:user) {build(:user)}

    context "user is not logged in" do
      it 'redirects to login if user is not signed in' do
        expect(User).to receive(:find_by_id).and_return(nil)
        post '/job_offers/create'
        expect(last_response).to be_redirect
      end
    end

    context "user is logged in" do
      it 'renders the post page if form is invalid' do
        expect(User).to receive(:find_by_id).and_return(user)
        post '/job_offers/create'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to include('/job_offers/index')
      end
    end
  end
end
