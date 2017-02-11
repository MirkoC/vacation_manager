class Manager::RegistrationsController < Devise::RegistrationsController
  # POST /managers
  def create
    @manager = Manager.new(registration_params)
    if @manager.save
      render :show
    else
      render json: { errors: @manager.errors }, status: :bad_request
    end
  end

  # PUT /managers
  # def update
  # end

  private

  def registration_params
    params.permit(:email, :password, :password_confirmation, :full_name)
  end
end
