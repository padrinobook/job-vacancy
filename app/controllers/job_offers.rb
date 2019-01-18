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
      @job_offer.user = current_user
      @job_offer.save

      redirect url(:job_offers, :mylist, id: current_user.id), flash[:notice] = "Job is saved"
    end

    render 'new'
  end
end
