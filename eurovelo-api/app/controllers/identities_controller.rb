class IdentitiesController < ApplicationController
  before_action :set_identity, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /identities
  def index
    @identities = Identity.all

    render json: @identities
  end

  # GET /identities/1
  def show
    render json: @identity
  end

  # POST /identities
  def create
    @identity = Identity.new(identity_params)

    if @identity.save
      render json: @identity, status: :created, location: @identity
    else
      render json: @identity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /identities/1
  def update
    if @identity.update(identity_params)
      render json: @identity
    else
      render json: @identity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /identities/1
  def destroy
    @identity.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_identity
      @identity = Identity.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def identity_params
      params.require(:identity).permit(:link, :provider, :place_id)
    end
end
