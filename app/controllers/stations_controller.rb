class StationsController < ApplicationController

  before_action :set_station, only: [:show, :edit, :update, :destroy, :rate]

  respond_to :html, :json

  before_action :authenticate_rider!, unless: 'is_cibot?'
  before_action :api_auth_rider!, if: 'is_cibot?'

  def index
    @stations = Station.with_rider_ratings(current_rider).order(id: :asc)
    respond_with(@stations)
  end

  def show
    respond_with(@station)
  end

  def new
    @station = Station.new
    respond_with(@station)
  end

  def edit
  end

  def create
    @station = Station.new(station_params)
    @station.save
    respond_with(@station)
  end

  def update
    @station.update(station_params)
    respond_with(@station)
  end

  def destroy
    @station.destroy
    respond_with(@station)
  end

  def rate

    rating = current_rider.update_rating(@station, rating_params[:value])

    respond_to do |f|
      f.json { render json: rating }
      f.html { redirect_to :back }
    end

  end

  private
    def set_station
      @station = Station.find(params[:id])
    end

    def station_params
      params.require(:station).permit(:name)
    end

    def rating_params
      params.require(:rating).permit(:value)
    end

end
