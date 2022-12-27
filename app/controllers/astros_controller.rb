class AstrosController < ApplicationController
  def index
    @astros = Astro.all
  end
end
