JobVacancy.controllers :page do
  get :home, :map => "/" do
    render 'page/home'
  end

  get :about, :map => '/about' do
    render 'page/about'
  end

  get :contact , :map => "/contact" do
    render 'page/contact'
  end

end
