class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :update, :destroy]
  before_action :parse_params, only: [:create, :update]
  load_and_authorize_resource
  
  resource_description do
    name 'Places'
    description %Q{
      Menage objects.
    }
  end
  def_param_group :place do
    param :name, String, :desc => "Object name"
    param :short_desc, String, :desc => "Object short description"
    param :long_desc, String, :desc => "Object long description"
    param :latitude, BigDecimal, :desc => "Latitude"
    param :longitude, BigDecimal, :desc => "Longitude"
    param :category_id, Integer, :desc => "Object category"
    param :region_id, Integer, :desc => "Object region"
    param :author, String, :desc => "Object author"
  end

  # GET /places (format: json xlsx)
  api :GET, "/places/api_index", "List all objects"
  example %q{
    [
      {
		"id": 1,
		"name": "South California Institute",
		"short_desc": "Nihil ipsum dolorum temporibus.",
		"long_desc": "Vel distinctio facere iusto qui facilis. Officia iste autem voluptas odio est. Minus delectus quasi. Ea et ea ipsum.",
		"latitude": "41.296545",
		"longitude": "65.244588",
		"region_name": "Midtjylland",
		"main_category": "Things to do",
		"sub_category": "Activities",
		"country_name": "Denmark",
		"sub_sub_category": "Other Activities",
		"created_at": "2018-05-09T08:40:10.563Z",
		"updated_at": "2018-05-03T16:19:33.563Z",
		"place_category": {
			"id": 1,
			"place_id": 1,
			"category_id": 2,
			"created_at": "2018-05-10T09:14:27.608Z",
			"updated_at": "2018-05-10T09:14:27.608Z"
		},
		"region_id": 7,
		"author": "Jillian Schoen",
		"addresses": [
			{
				"id": 1,
				"street": "Twila Plains",
				"street_number": "804",
				"city": "Cartwrightberg",
				"postcode": "31961",
				"phone": "1-434-153-3522 x8536",
				"cellphone": "1-131-541-8249",
				"email": "oscar@funkschneider.name",
				"link": "http://larson.co/modesta",
				"addressable_id": 1,
				"addressable_type": "Place"
			}
		],
		"videos": [
			{
				"id": 1,
				"title": "Toto, I've got a feeling we're not in Kansas anymore.",
				"link": "http://kihn.org/annie_wilderman"
			},
			{
				"id": 108,
				"title": null,
				"link": "www.youtube.com"
			}
		],
		"pictures": [
			{
				"id": 1,
				"source": "http://localhost:3000/system/pictures/sources/000/000/001/original/rerumdelectuset.png?1525943668",
				"main": true
			}
		],
		"attachments": [
			{
				"id": 2,
				"source": "http://localhost:3000/system/attachments/sources/000/000/002/original/Places.xlsx?1527064067",
				"source_file_name": "Places.xlsx"
			}
		],
		"identities": [
			{
				"id": 1,
				"link": "http://tromp.com/jamel_pacocha",
				"provider": "Facebook",
				"place_id": 1
			}
		]
	}
    ]
  }
  param_group :place
  def index
    @places = Place.all
    
    unless !request.format.json?
      @q = @places.ransack(params[:q])    
      @places = @q.result.includes(:region, :addresses, :main_category, :user, :place_category).page(params[:page]).order("created_at DESC")
    end
    
    respond_to do |format|
      format.json { render json: {data: ActiveModel::Serializer::CollectionSerializer.new(@places, serializer: PlaceSerializer), size: @places.total_count}}
      format.xlsx { render xlsx: 'Objects', template: 'places/index'}
    end
  end
  
  def api_index
    @places = Place.all
    render json: @places, each_serializer: ApiPlaceSerializer
  end

  # GET /places/1
  def show
    render json: @place, serializer: PlaceShowSerializer
  end

  # POST /places
  def create
    @place = Place.new(place_params)

    if @place.save
      render json: @place, status: :created, location: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /places/1
  def update
    if @place.update(place_params)
      render json: @place
    else
      render json: @place.errors, status: :unprocessable_entity
    end
  end

  # DELETE /places/1
  def destroy
    @place.destroy
  end
  
  def import
    res = Place.import(params[:file])
    render json: res
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_place
      @place = Place.find(params[:id])
    end
    
    def parse_params
     params[:addresses_attributes] = JSON.parse(params[:addresses_attributes]) if !params[:addresses_attributes].blank?
     params[:identities_attributes] = JSON.parse(params[:identities_attributes]) if !params[:identities_attributes].blank?
     params[:videos_attributes] = JSON.parse(params[:videos_attributes]) if !params[:videos_attributes].blank?
   end
   
    # Only allow a trusted parameter "white list" through.
    def place_params
      params.permit(:id, :name, :short_desc, :long_desc, :latitude, :longitude, :region_id, :category_id, :user_id, :author,
        addresses_attributes: [:id, :street, :street_number, :city, :postcode, :phone, :cellphone, :email, :link, :addressable_id, :addressable_type, :_destroy],
        videos_attributes: [:id, :title, :link, :videoable_type, :videoable_id, :_destroy],
        pictures_attributes: [:id, :main, :source, :picturable_id, :picturable_type, :_destroy],
        identities_attributes: [:id, :link, :provider, :place_id, :_destroy],
        attachments_attributes: [:id, :source, :attachmentable_id, :attachmentable_type, :_destroy])
    end
end
