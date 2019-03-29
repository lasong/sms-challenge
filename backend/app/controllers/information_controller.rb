class InformationController < ApplicationController
  def index
    render json: query_information.map { |info| serialize(info) }
  end

  private

  def query_information
    if params[:start_date].present? && params[:end_date].present?
      return Information.where(
        'start_date >= ? AND end_date <= ?', params[:start_date], params[:end_date])
    end

    Information.all
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
