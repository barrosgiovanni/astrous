class AstrosController < ApplicationController
  def index
    if params[:query].present?
      @astros = Astro.search_astros(params[:query])
    else
      @astros = Astro.all
    end
  end
end
