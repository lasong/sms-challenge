class InformationController < ApplicationController
  before_action :set_information, only: [:show, :update, :destroy]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  def index
    render json: query_information.map { |information| serialize(information) }
  end

  def show
    render json: serialize(@information)
  end

  def create
    info = Information.create(information_params)

    if info.invalid?
      render json: { errors: info.errors }, status: :unprocessable_entity and return
    end

    render json: serialize(info), status: :created
  end

  def update
    @information.update(information_params)

    if @information.invalid?
      errors = @information.errors
      render json: { errors: errors }, status: :unprocessable_entity and return
    end

    render json: serialize(@information)
  end

  def destroy
    @information.destroy

    render json: { message: 'Information successfully deleted' }
  end

  private

  def set_information
    @information = Information.find(params[:id])
  end

  def information_params
    params.require(:information).permit(
      :city, :start_date, :end_date, :price, :status, :color)
  end

  def query_information
    if params[:start_date].present? && params[:end_date].present?
      return Information.where(
        'start_date >= ? AND end_date <= ?', params[:start_date], params[:end_date])
    end

    Information.all
  end

  def handle_record_not_found
    render json: { error: 'Information not found' }, status: :not_found
  end

  def serialize(information)
    {
      id: information.id,
      city: information.city,
      start_date: information.start_date.strftime('%Y-%m-%d'),
      end_date: information.end_date.strftime('%Y-%m-%d'),
      price: information.price,
      status: information.status,
      color: information.color
    }
  end
end
