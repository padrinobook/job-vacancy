JobVacancy::App.controllers :forget_password do

  get :new, :map => 'forget_password'  do
    render 'new'
  end

  post :create do
    render 'success'
  end
end

