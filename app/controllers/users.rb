JobVacancy.controllers :users do

  get :new, :map => "/login" do
    render 'users/new'
  end

end
