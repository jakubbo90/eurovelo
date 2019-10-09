class CategoryDescriptionsController < ApplicationController
  before_action :set_category_description, only: [:show, :update]
  before_action :parse_params, only: [:update]
  load_and_authorize_resource
  
  def index
    @category_descriptions = CategoryDescription.all

    respond_to do |format|
      format.json { render json: {data: ActiveModel::Serializer::CollectionSerializer.new(@category_descriptions, serializer: CategoryDescriptionSerializer)}}
      format.xlsx { render xlsx: 'Descriptions', template: 'category_descriptions/index'}
    end
  end

  # GET /category_descriptions/1
  def show
    render json: @category_description
  end

  # PATCH/PUT /category_descriptions/1
  def update
    if @category_description.update(category_description_params)
      render json: @category_description
    else
      render json: @category_description.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category_description
      @category_description = CategoryDescription.find(params[:id])
    end
    
    def parse_params
     params[:videos_attributes] = JSON.parse(params[:videos_attributes]) if !params[:videos_attributes].blank?
   end

    # Only allow a trusted parameter "white list" through.
    def category_description_params
      params.permit(:user_id, :title, :short_desc, :long_desc, :name,
        videos_attributes: [:id, :title, :link, :videoable_type, :videoable_id, :_destroy],
        pictures_attributes: [:id, :main, :source, :picturable_id, :picturable_type, :_destroy])
    end
end
