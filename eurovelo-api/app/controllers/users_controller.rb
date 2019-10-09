class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy, :reset_password]
  load_and_authorize_resource

  # GET /users
  def index
    @users = User.all
    
    unless !request.format.json?
      @q = @users.ransack(params[:q])    
      @users = @q.result.page(params[:page]).order("last_name ASC")
    end
    
    if request.format.xlsx?
      if current_user.role == "super_admin"
        @users = User.all.where.not(role: "super_admin")
      else
        @users = User.all.where(role: "author", region: current_user.region)
      end
    end
    
    respond_to do |format|
      format.json { render json: {data: ActiveModel::Serializer::CollectionSerializer.new(@users, serializer: UserSerializer), size: @users.total_count}}
      format.xlsx { render xlsx: 'Users', template: 'users/index'}
    end
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    if @user.destroy
      @user.change_objects_owner(params[:new_user_id])
    end
  end
  
  def reset_password
    new_password = Devise.friendly_token(50) + "R$"
    @user.password = new_password
    @user.password_confirmation = new_password
    @user.skip_email = true
    @user.save
    @user.send_reset_password_instructions
    render json: @user, status: :ok
  end
  
  def roles
    @roles = Role.all
    render json: @roles
  end
  
  def my_posts
    user = current_user
    @posts = user.trails.select(:id, :name, :created_at, :updated_at) + user.places.select(:id, :name, :created_at, :updated_at) + user.alerts.select(:id, :name, :created_at, :updated_at)
    if params[:sortby] && params[:sortdir]
      if params[:sortby] == "created"
        if params[:sortdir] == "asc"
          @posts = @posts.sort_by {|k| k["created_at"]}
        else
          @posts = @posts.sort_by {|k| k["created_at"]}.reverse
        end
      elsif params[:sortby] == "modified"
        if params[:sortdir] == "asc"
          @posts = @posts.sort_by {|k| k["updated_at"]}
        else
          @posts = @posts.sort_by {|k| k["updated_at"]}.reverse
        end
      end
    end
    render json: {data: ActiveModel::Serializer::CollectionSerializer.new(@posts, serializer: UserPostSerializer), size: @posts.count}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:first_name, :last_name, :phone, :email, :company, :password, :role, :parent_id, :region_id, :accept_terms)
    end

end
