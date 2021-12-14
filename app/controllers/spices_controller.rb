class SpicesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :handle_error
  wrap_parameters format: []

  def index
    spices = Spice.all
    render json: spices, status: :ok
  end

  def create
    new_spice = Spice.create(accepted_params)
    render json: new_spice, status: :created
  end

  def update
    found_spice = find_spice
    found_spice.update(accepted_params)
    render json: found_spice, status: :accepted
  end

  def destroy
    found_spice = find_spice
    found_spice.destroy
    render json: {}, status: :accepted
  end

  private

  def accepted_params
    params.permit(:title, :image, :description, :notes, :rating)
  end

  def find_spice
    Spice.find_by(id: params[:id])
  end

  def handle_error
    render json: {
             error: 'spice not found. spice will not flow.',
           },
           status: :not_found
  end
end
