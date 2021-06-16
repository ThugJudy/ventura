class FavouritesController < ApplicationController
  def update

    favourite = Favourite.where(idea: Idea.find(params[:idea]), user: current_user)
    if favourite == []
      Favourite.create(idea: Idea.find(params[:idea]),user: current_user)
      @favourite_exists = true
    else
      Favourite.destroy_all
      favourite_exists = false
    end
    respond_to do |format|
      format.html {}
      format.js {}
    end
  end
end
