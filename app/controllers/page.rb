JobVacancy::App.controllers :page do
  get :home, :map => "/" do
    render 'home'
  end

  get :about, :map => '/about' do
    render 'about'
  end

  get :contact , :map => "/contact" do
    render 'contact'
  end
end
