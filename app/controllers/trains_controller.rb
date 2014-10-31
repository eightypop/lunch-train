class TrainsController < ApplicationController
  before_action :set_train, only: [:show, :edit, :update, :destroy, :on, :off]
  before_action :authenticate_rider!
  respond_to :html

  def index
    @trains = Train.where('depart_time >= ?',  Time.zone.now.beginning_of_day )
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
    @train = Train.new(train_params)
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
    redirect_to :back
  end

  def off
    @train.riders.delete(current_rider)
    redirect_to :back
  end

  private
    def set_train
      @train = Train.find(params[:id])
    end

    def train_params
      params.require(:train).permit(:depart_time)
    end

end
