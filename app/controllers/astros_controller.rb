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
  end

  private

  def set_astro
    @astro = Astro.find(params[:id])
  end
end
