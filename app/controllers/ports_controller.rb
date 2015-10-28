class PortsController < ApplicationController
  before_action :set_port, only: [:show, :edit, :update, :destroy]
  before_action :set_location

  # GET /ports
  def index
    @ports = Port.all
  end

  # GET /ports/1
  def show
  end

  # GET /ports/new
  def new
    @port = @location.ports.new
  end

  # GET /ports/1/edit
  def edit
  end

  # POST /ports
  def create
    @port = @location.ports.new(port_params)

    if @port.save
      redirect_to @port, notice: 'Port was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /ports/1
  def update
    if @port.update(port_params)
      redirect_to @port, notice: 'Port was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /ports/1
  def destroy
    @port.destroy
    redirect_to location_ports_url(@location), notice: 'Port was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_port
      @port = Port.find(params[:id])
    end

    def set_location
      if params[:location_id]
        @location = Location.find(params[:location_id])
      else
        @location = @port.location
      end
    end

    # Only allow a trusted parameter "white list" through.
    def port_params
      case
      when params[:input]
        p = params.require(:input)
      when params[:output]
        p = params.require(:output)
      else
        p = params.require(:port)
      end
      p.permit(:location_id, :type, :number, :signal_type, :name)
    end
end
