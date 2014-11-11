require 'time'
class TrainsController < ApplicationController
  before_action :set_train, only: [:show, :edit, :update, :destroy, :on, :off]
  before_action :authenticate_rider!, unless: 'is_cibot?'
  before_action :api_auth_rider!, if: 'is_cibot?'
  respond_to :html, :json

  def index
    @trains = Train.today.includes(:riders)
    respond_with(@trains)
  end

  def show
    respond_with(@train)
  end

  def new
    @train = Train.new
    respond_with(@train)
  end

  def edit
  end

  def create
    #format input to discard day, month settings and use today
    given_time = Time.parse(train_params[:depart_time])
    actual_time = Time.parse("#{given_time.hour}: #{given_time.min}")
    @train = Train.new(depart_time: actual_time)
    @train.riders << current_rider
    @train.save
    respond_with(@train)
  end

  def update
    @train.update(train_params)
    respond_with(@train)
  end

  def destroy
    @train.riders.clear
    @train.destroy
    respond_with(@train)
  end

  def on
    @train.riders << current_rider
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { respond_with  @train }
    end
  end

  def off
    @train.riders.delete(current_rider)
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { respond_with @train }
    end
  end

  private
    def set_train
      @train = Train.find(params[:id])
    end

    def train_params
      params.require(:train).permit(:depart_time)
    end

end
