class AlertsController < ApplicationController
  before_action :set_alert, only: [:show, :update, :destroy]
  before_action :parse_params, only: [:create, :update]
  load_and_authorize_resource

  # GET /alerts
  def index
    @alerts = Alert.all

    unless !request.format.json?
      @q = @alerts.ransack(params[:q])
      @alerts = @q.result.page(params[:page]).per(25).order("created_at DESC")
    end

    respond_to do |format|
      format.json { render json: {data: ActiveModel::Serializer::CollectionSerializer.new(@alerts, serializer: AlertSerializer), size: @alerts.total_count}}
      format.xlsx { render xlsx: 'Alerts', template: 'alerts/index'}
    end
  end

  # GET /alerts/1 
  def show
    render json: @alert
  end

  # POST /alerts
  def create
    @alert = Alert.new(alert_params)

    if @alert.save
      render json: @alert, status: :created, location: @alert
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /alerts/1
  def update
    if @alert.update(alert_params)
      render json: @alert
    else
      render json: @alert.errors, status: :unprocessable_entity
    end
  end

  # DELETE /alerts/1
  def destroy
    @alert.destroy
  end

  def import
    res = Alert.import(params[:file])
    render json: res
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alert
      @alert = Alert.find(params[:id])
    end

    def parse_params
     params[:addresses_attributes] = JSON.parse(params[:addresses_attributes]) if !params[:addresses_attributes].blank?
   end

    # Only allow a trusted parameter "white list" through.
    def alert_params
      params.permit(:name, :time_from, :time_to, :description, :user_id, :latitude, :longitude, :region_id, :author,
      pictures_attributes: [:id, :source, :picturable_id, :picturable_type, :_destroy, :main],
      addresses_attributes: [:id, :city, :addressable_id, :addressable_type, :_destroy])
    end
end
