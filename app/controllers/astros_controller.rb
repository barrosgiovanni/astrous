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
  end

  def show
    @booking = Booking.new
    # description = Astronomy::Information.new.search '#{@astro.name}'
    # astro_info = Astronomy::Information.new.search "Uranus"
    # astro_info.each { |astro| puts astro["description"] if astro["name"] == "Uranus" }
  end

  def new
    @astro = Astro.new
  end

  def create
    @astro = Astro.new(astro_params)
    @astro.user = current_user
    @astro.save
    redirect_to astro_path(@astro), notice: "Astro was successfully created!"
  end

  def edit
  end

  def update
    @astro.update(astro_params)
    @astro.save
    redirect_to astro_path(@astro), notice: "Astro was successfully updated!"
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
    params.require(:astro).permit(:name, :body_type, :average_temperature, :density, :gravity, :mean_radius, :discovered_by, :discovered_date, :price, :image_url, :around_planet, :mass_value, :volume, :description)
  end
end
