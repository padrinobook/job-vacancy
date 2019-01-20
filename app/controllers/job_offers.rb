JobVacancy::App.controllers :job_offers do
  before :create, :mylist, :edit do
    redirect('/login') unless signed_in?
    @user = User.find_by_id(params[:id])
    redirect('/login') unless current_user?(@user)
  end

  get :jobs, :map => '/jobs' do
    render 'jobs'
  end

  get :new, :map => '/jobs/new' do
    @job_offer = JobOffer.new
    render 'new'
  end

  get :mylist, :map => '/jobs/mylist' do
    @job_offers = JobOffer.where("user_id = ?", current_user.id)

    render 'mylist', :locals => { job_offers: @job_offers }
  end

  post :create, :map => '/jobs/create' do
    @job_offer = JobOffer.new(params[:job_offer])

    if @job_offer && @job_offer.valid?
      @job_offer.write_attribute(user: current_user)
      @job_offer.save

      redirect url(:job_offers, :mylist, id: current_user.id), flash[:notice] = "Job is saved"
    end

    render 'new'
  end

  get :edit, :map => '/jobs/myjobs/:id/edit' do
    current_job_offer = JobOffer.where("id = ?", params[:id])

    if current_job_offer.user != @user
      redirect url(:job_offers, :mylist)
    end


    render 'edit'
  end

  put :update, :map => '/jobs/myjobs/:id' do
    @job_offer = JobOffer.find(params[:id])

    if @job_offer == nil
      redirect url(:job_offers, :mylist)
    end

    if @job_offer && @job_offer.update_attributes(params[:job_offer])
      redirect url(:job_offers, :mylist), flash[:notice] = 'Job offer was updated.'
    end

    redirect url(:job_offers, :edit, id: params[:id]), flash[:error] = 'Job offer was not updated.'
  end
end
