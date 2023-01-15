class AstrosController < ApplicationController
  before_action :set_astro, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    if params[:query].present?
      # @astros = Astro.search_astros(params[:query])
      @pagy, @astros = pagy(Astro.search_astros(params[:query]))
    else
      # @astros = Astro.all
      @pagy, @astros = pagy(Astro.all)
    end

    respond_to do |format|
      format.html # GET
      format.turbo_stream # POST
    end
  end

  def show
    @booking = Booking.new
    # description = Astronomy::Information.new.search '#{@astro.name}'
    # astro_info = Astronomy::Information.new.search "Uranus"
    # astro_info.each { |astro| puts astro["description"] if astro["name"] == "Uranus" }
    @bookings = @astro.bookings
  end

  def new
    @astro = Astro.new
  end

  def create
    @astro = Astro.new(astro_params)
    @astro.user = current_user
    if @astro.save
      redirect_to astro_path(@astro)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @astro.update(astro_params)
    if @astro.save
      redirect_to astro_path(@astro)
    else
      render :new
    end
  end

  def destroy
    @astro.destroy
    redirect_to astros_path, status: :see_other
  end

  private

  def set_astro
    @astro = Astro.find(params[:id])
  end

  def astro_params
    params.require(:astro).permit(:name, :body_type, :around_planet, :description, :mass_value, :volume, :average_temperature, :density, :gravity, :mean_radius, :discovered_by, :discovered_date, :image_url, :photo, :price)
  end
end
