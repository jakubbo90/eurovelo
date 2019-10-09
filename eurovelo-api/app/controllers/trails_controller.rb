class TrailsController < ApplicationController
  before_action :set_trail, only: [:show, :update, :destroy]
  before_action :parse_params, only: [:create, :update]
  load_and_authorize_resource

  # GET /trails
  def index
    @trails = Trail.all

    unless !request.format.json?
      @q = @trails.ransack(params[:q])
      @trails = @q.result.page(params[:page]).order("created_at DESC")
    end

    respond_to do |format|
      format.json { render json: {data: ActiveModel::Serializer::CollectionSerializer.new(@trails, serializer: TrailSerializer), size: @trails.total_count}}
      format.xlsx { render xlsx: 'Trails', template: 'trails/index' }
    end
  end

  # GET /trails/1
  def show
    render json: @trail
  end

  # POST /trails
  def create
    @trail = Trail.new(trail_params)

    if @trail.save
      render json: @trail, status: :created, location: @trail
    else
      render json: @trail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trails/1
  def update
    if @trail.update(trail_params)
      render json: @trail
    else
      render json: @trail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trails/1
  def destroy
    @trail.destroy
  end

  def import
    res = Trail.import(params[:file])
    render json: res
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trail
      @trail = Trail.find(params[:id])
    end
    
    def parse_params
     params[:videos_attributes] = JSON.parse(params[:videos_attributes]) if !params[:videos_attributes].blank?
     params[:trail_places_attributes] = JSON.parse(params[:trail_places_attributes]) if !params[:trail_places_attributes].blank?
   end

    # Only allow a trusted parameter "white list" through.
    def trail_params
      params.permit(:user_id, :name, :short_desc, :long_desc, :distance, :category_id, :region_id, :author,
        videos_attributes: [:id, :title, :link, :videoable_type, :videoable_id, :_destroy],
        pictures_attributes: [:id, :source, :picturable_id, :picturable_type, :main, :_destroy],
        attachments_attributes: [:id, :source, :attachmentable_id, :attachment_type, :_destroy],
        trail_places_attributes: [:id, :place_id, :_destroy])
    end
end
