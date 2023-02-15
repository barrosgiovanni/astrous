class AstrosController < ApplicationController
  before_action :set_astro, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[show index]

  def index
    if params[:query].present?
      # @astros = Astro.search_astros(params[:query])
      @pagy, @astros = pagy(Astro.search_astros(params[:query]))
    else
      # @astros = Astro.all
      @pagy, @astros = pagy(Astro.all)
    end

    respond_to do |format|
      format.html
      format.json {
        render json: { entries: render_to_string(partial: 'astros', formats: [:html]), pagination: view_context.pagy_bootstrap_nav(@pagy) }
      }
    end
  end

  def show
    authorize @astro
    @booking = Booking.new
    # description = Astronomy::Information.new.search '#{@astro.name}'
    # astro_info = Astronomy::Information.new.search "Uranus"
    # astro_info.each { |astro| puts astro["description"] if astro["name"] == "Uranus" }
  end

  def new
    @astro = Astro.new
    authorize @astro
  end

  def create
    @astro = Astro.new(astro_params)
    @astro.user = current_user
    authorize @astro
    if @astro.save
      redirect_to astro_path(@astro), notice: "Astro was successfully listed!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @astro.update(astro_params)
    if @astro.save
      redirect_to astro_path(@astro), notice: "Astro was successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @astro.destroy
    redirect_to astros_path, status: :see_other
  end

  # to see all the astros that have been listed by the current user ...
  def listed_astros
    @astros = current_user.astros
  end

  private

  def set_astro
    @astro = Astro.find(params[:id])
  end

  def astro_params
    params.require(:astro).permit(:name,
                                  :body_type,
                                  :around_planet,
                                  :description,
                                  :mass_value,
                                  :volume,
                                  :average_temperature,
                                  :density,
                                  :gravity,
                                  :mean_radius,
                                  :discovered_by,
                                  :discovered_date,
                                  :image_url,
                                  :photo,
                                  :price,
                                  )
  end
end
