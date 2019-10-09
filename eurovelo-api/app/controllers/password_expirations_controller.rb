class PasswordExpirationsController < ApplicationController
  before_action :set_password_expiration, only: [:show, :update, :destroy]
  load_and_authorize_resource

  # GET /password_expirations
  def index
    @password_expirations = PasswordExpiration.last

    render json: @password_expirations
  end

  # GET /password_expirations/1
  def show
    render json: @password_expiration
  end

  # POST /password_expirations
  def create
    @password_expiration = PasswordExpiration.new(password_expiration_params)

    if @password_expiration.save
      render json: @password_expiration, status: :created, location: @password_expiration
    else
      render json: @password_expiration.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /password_expirations/1
  def update
    if @password_expiration.update(password_expiration_params)
      render json: @password_expiration
    else
      render json: @password_expiration.errors, status: :unprocessable_entity
    end
  end

  # DELETE /password_expirations/1
  def destroy
    @password_expiration.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_password_expiration
      @password_expiration = PasswordExpiration.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def password_expiration_params
      params.permit(:expiration_date, :period_in_days)
    end
end
