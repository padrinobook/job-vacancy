JobVacancy::App.controllers :job_offers do
  before :create do
    redirect('/login') unless signed_in?
  end

  get :list do
    render 'list'
  end

  get :index, :map => '/job_offers/index' do
    render 'index'
  end

  post :create do
    redirect url(:job_offers, :index)
  end
end
