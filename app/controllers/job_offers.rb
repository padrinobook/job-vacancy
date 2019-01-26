JobVacancy::App.controllers :job_offers do
  before :new, :create, :mylist, :edit do
    if !signed_in?
      redirect('/login')
    end
  end

  get :index, :map => '/jobs' do
    @job_offers = JobOffer.all
    render 'jobs', :locals => { job_offers: @job_offers }
  end

  get :new, :map => '/jobs/new' do
    @job_offer = JobOffer.new
    render 'new'
  end

  post :create, :map => '/jobs/create' do
    @job_offer = JobOffer.new(params[:job_offer])

    if @job_offer && @job_offer.valid?
      @job_offer.write_attribute(:user_id, current_user.id)
      @job_offer.save
      redirect url(:job_offers, :mylist), flash[:notice] = "Job is saved"
    end

    render 'new'
  end

  get :mylist, :map => '/jobs/mylist' do
    @job_offers = JobOffer.where("user_id = ?", current_user.id)
    render 'mylist', :locals => { job_offers: @job_offers }
  end

  get :edit, :map => '/jobs/myjobs/:id/edit' do
    @job_offer = JobOffer.find_by_id(params[:id])

    if @job_offer && @job_offer.user.id != current_user.id
      redirect url(:job_offers, :mylist)
    end

    render 'edit', :locals => { job_offer: @job_offer }
  end

  put :update, :map => '/jobs/myjobs/:id' do
    @job_offer = JobOffer.find_by_id(params[:id])

    if @job_offer == nil
      redirect url(:job_offers, :mylist)
    end

    begin
      if @job_offer.update_attributes!(params[:job_offer])
        redirect url(:job_offers, :mylist), flash[:notice] = 'Job offer was updated.'
      end
    rescue ActiveRecord::RecordInvalid
      redirect url(:job_offers, :edit, id: params[:id]), flash[:error] = 'Job offer changes were not valid'
    end

    redirect url(:job_offers, :edit, id: params[:id]), flash[:error] = 'Job offer was not updated.'
  end

  get :job, :map => '/jobs/:id' do
    @job_offer = JobOffer.find_by_id(params[:id])

    if @job_offer
      render 'job', :local => { job_offer: @job_offer }
    else
      render 'jobs'
    end
  end
end
