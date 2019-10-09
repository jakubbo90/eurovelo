class TrailCategoriesController < ApplicationController
  before_action :set_trail_category, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /trail_categories
  def index
    @trail_categories = TrailCategory.where(level: "main")

    render json: ActiveModel::Serializer::CollectionSerializer.new(@trail_categories, serializer: CategorySerializer)
  end

  # GET /trail_categories/1
  def show
    render json: @trail_category
  end

  # POST /trail_categories
  def create
    @trail_category = TrailCategory.new(trail_category_params)

    if @trail_category.save
      render json: @trail_category, status: :created, location: @trail_category
    else
      render json: @trail_category.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trail_categories/1
  def update
    if @trail_category.update(trail_category_params)
      render json: @trail_category
    else
      render json: @trail_category.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trail_categories/1
  def destroy
    @trail_category.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trail_category
      @trail_category = TrailCategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trail_category_params
      params.require(:trail_category).permit(:name, :parent_id, :level)
    end
end
