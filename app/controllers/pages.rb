JobVacancy::App.controllers :pages do
  get :home, :map => "/" do
    redirect url(:job_offers, :index)
  end

  get :about, :map => '/about' do
    render 'about'
  end

  get :contact , :map => "/contact" do
    render 'contact'
  end
end

