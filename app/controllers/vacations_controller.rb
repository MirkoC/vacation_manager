class VacationsController < ApplicationController
  include JwtAuth

  before_action :authenticate_request!, :find_for_who_to_schedule

  def create
    @vacation = Vacation.new(vacation_params.merge vacationable: (@manager || @worker))
    if @vacation.save
      render :show
    else
      render json: { errors: @vacation.errors }, status: :bad_request
    end
  end

  private

  def find_for_who_to_schedule
    @manager = Manager.find_by_id(params[:manager_id])
    return @manager if @manager
    @worker = Worker.find_by_id(params[:worker_id])
    return @worker if @worker
    return render json: { errors: { manager_or_worker: [:not_found] } },
                  status: :not_found
  end

  def vacation_params
    params.permit(:start_date, :end_date)
  end
end
