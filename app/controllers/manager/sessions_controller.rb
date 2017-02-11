class Manager::SessionsController < Devise::SessionsController
  # POST /resource/sign_in
  before_action :find_manager

  def create
    if @manager.valid_password?(params[:password])
      render :show
    else
      render json: { errors: { password: [:invalid_password] } }, status: :bad_request
    end
  end

  private

  def find_manager
    @manager = Manager.find_by_email(params[:email])
    return render json: { errors: { manager: [:not_found] } },
                  status: :not_found unless @manager
  end
end
