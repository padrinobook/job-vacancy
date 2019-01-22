require 'spec_helper'

RSpec.describe "/job_offers" do
  let(:user) { build_stubbed(:user) }
  describe "GET /jobs" do
    it "render the :jobs view" do
      get "/jobs"
      expect(last_response).to be_ok
    end
  end

  describe "GET /jobs/new" do
    it 'renders the :new routes' do
      get "/jobs/new"
      expect(last_response).to be_ok
    end
  end

  describe "GET /jobs/mylist" do
    context "user is not logged in" do
      it 'redirects to login' do
        expect(User).to receive(:find_by_id).and_return(nil)
        get '/jobs/mylist'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to include('/login')
      end
    end

    context "user is logged in" do
      it 'renders list of users job offers' do
        expect(User).to receive(:find_by_id).and_return(user)
        get "/jobs/mylist"
        expect(last_response).to be_ok
      end
    end
  end

  describe "POST /jobs/create" do
    context "user is not logged in" do
      it 'redirects to login' do
        expect(User).to receive(:find_by_id).and_return(nil)
        post '/jobs/create'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to include('/login')
      end
    end

    context "user is logged in" do
      let(:user) { build_stubbed(:user) }
      let(:job) { build_stubbed(:job_offer) }

      it 'renders the post page if form is invalid' do
        expect(User).to receive(:find_by_id).and_return(user)
        expect(JobOffer).to receive(:new).and_return(job)
        expect(job).to receive(:valid?).and_return(false)

        post '/jobs/create'
        expect(last_response).to be_ok
      end

      it 'list page if job offer is saved' do
        expect(User).to receive(:find_by_id).and_return(user)
        expect(JobOffer).to receive(:new).and_return(job)
        expect(job).to receive(:valid?).and_return(true)
        expect(job).to receive(:write_attribute)
          .with(:user_id, user.id)
          .and_return(true)

        expect(job).to receive(:save).and_return(true)

        post '/jobs/create', job_offer: job
        expect(last_response).to be_redirect
        expect(last_response.body).to eq "Job is saved"
      end
    end
  end

  describe "GET /jobs/myjobs/:id/edit" do
    let(:job) { build_stubbed(:job_offer) }
    let(:user_second) { build_stubbed(:user) }

    it 'redirects to /login if user is not signed in' do
      expect(User).to receive(:find_by_id).and_return(nil)
      get '/jobs/myjobs/1/edit'
      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/login')
    end

    it 'redirects to /jobs/mylist if signed in user tries to edit a job from a different user' do
      expect(User).to receive(:find_by_id).and_return(user)
      job.user = user_second
      expect(JobOffer).to receive(:find_by_id)
        .with("#{job.id}")
        .and_return(job)

      get "/jobs/myjobs/#{job.id}/edit"

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/jobs/mylist')
    end

    it 'renders edit view if signed in user edits his own job' do
      expect(User).to receive(:find_by_id).and_return(user)
      job.user = user
      expect(JobOffer).to receive(:find_by_id)
        .with("#{job.id}")
        .and_return(job)

      get "/jobs/myjobs/#{job.id}/edit"

      expect(last_response).to be_ok
    end
  end

  describe "PUT /jobs/myjobs/:id" do
    it 'try to edit non existing job' do
      updated_job_offer = ['']
      expect(JobOffer).to receive(:find_by_id)
        .with('1000')
        .and_return(nil)

      put "/jobs/myjobs/1000", job_offer: updated_job_offer

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/jobs/mylist')
    end

    it 'job_offer changes are not valid' do
      @existing_job_offer = double(JobOffer, id: 1, title: 'old')
      updated_job_offer = ['']
      expect(JobOffer).to receive(:find_by_id)
        .with('1')
        .and_return(@existing_job_offer)
      expect(@existing_job_offer).to receive(:update_attributes!)
        .with(updated_job_offer)
        .and_return(false)

      put "/jobs/myjobs/1", job_offer: updated_job_offer

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/jobs/myjobs/1/edit')
      expect(last_response.body).to eq 'Job offer was not updated.'
    end

    it 'job_offer changes are valid' do
      @existing_job_offer = double(JobOffer, id: 1, title: 'old')
      updated_job_offer = ['']
      expect(JobOffer).to receive(:find_by_id)
        .with('1')
        .and_return(@existing_job_offer)
      expect(@existing_job_offer).to receive(:update_attributes!)
        .with(updated_job_offer)
        .and_return(true)

      put "/jobs/myjobs/1", job_offer: updated_job_offer

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/jobs/mylist')
      expect(last_response.body).to eq 'Job offer was updated.'
    end

    it 'job_offer changes DB error' do
      @existing_job_offer = double(JobOffer, id: 1, title: 'old')
      updated_job_offer = ['']
      expect(JobOffer).to receive(:find_by_id)
        .with('1')
        .and_return(@existing_job_offer)
      expect(@existing_job_offer).to receive(:update_attributes!)
        .with(updated_job_offer)
        .and_raise(ActiveRecord::RecordInvalid)

      put "/jobs/myjobs/1", job_offer: updated_job_offer

      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to include('/jobs/myjobs/1/edit')
      expect(last_response.body).to eq 'Job offer changes were not valid'
    end
  end
end
