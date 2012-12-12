JobVacancy.controllers :page do
  get :about, :map => '/about' do
    render :erb, 'page/about'
  end

  get :contact , :map => "/contact" do
    render :erb, 'page/contact'
  end

  get :home, :map => "/" do
    render :erb, 'page/home'
  end

end
