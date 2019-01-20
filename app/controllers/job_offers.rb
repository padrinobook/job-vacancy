JobVacancy::App.controllers :job_offers do
  before :create, :mylist do
    redirect('/login') unless signed_in?
    @user = User.find_by_id(params[:id])
  end

  get :list do
    render 'list'
  end

  get :mylist, :map => '/job_offers/mylist' do
    @job_offers = JobOffer.where("user_id = ?", current_user.id)

    render 'mylist', :locals => { job_offers: @job_offers }
  end

  get :new, :map => '/job_offers/new' do
    @job_offer = JobOffer.new
    render 'new'
  end

  post :create do
    @job_offer = JobOffer.new(params[:job_offer])

    if @job_offer && @job_offer.valid?
      @job_offer.write_attribute(user: current_user)
      @job_offer.save

      redirect url(:job_offers, :mylist, id: current_user.id), flash[:notice] = "Job is saved"
    end

    render 'new'
  end

  get :edit, :map => '/job_offers/myjobs/:id/edit' do
    render 'edit'
  end

  put :update, :map => '/job_offers/myjobs/:id' do
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
