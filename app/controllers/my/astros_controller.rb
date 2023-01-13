class My::AstrosController < ApplicationController
  def index
    @astros = current_user.astros
  end
end
