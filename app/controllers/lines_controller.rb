class LinesController < ApplicationController
  before_action :set_line, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index
    @lines = Line.all
    respond_with(@lines)
  end

  def show
    respond_with(@line)
  end

  def new
    @line = Line.new
    respond_with(@line)
  end

  def edit
  end

  def create
    @line = Line.new(line_params)
    @line.save
    respond_with(@line)
  end

  def update
    @line.update(line_params)
    respond_with(@line)
  end

  def destroy
    @line.destroy
    respond_with(@line)
  end

  private
    def set_line
      @line = Line.find(params[:id])
    end

    def line_params
      params.require(:line).permit(:name, :time_zone)
    end
end
