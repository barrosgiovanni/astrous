class AstrosController < ApplicationController
  before_action :set_astro, only: [:show, :destroy]

  def index
    if params[:query].present?
      @astros = Astro.search_astros(params[:query])
    else
      @astros = Astro.all
    end
  end

  def show
    # description = Astronomy::Information.new.search '#{@astro.name}'
  end

  private

  def set_astro
    @astro = Astro.find(params[:id])
  end
end

# [
#   {"description" =>

#     "images" =>
#     "name" =>
# ]


# data["description"]["name"]
