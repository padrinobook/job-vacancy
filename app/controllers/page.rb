JobVacancy.controllers :page do
  get :about, :map => '/about' do
    render 'page/about'
  end

  get :contact , :map => "/contact" do
    render 'page/contact'
  end

  get :home, :map => "/" do
    render 'page/home'
  end

end
