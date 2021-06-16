module FavouritesHelper
  def favourite_text
    return @favourite_exists ? "Unmark this Idea" : "Mark this Idea"
  end
end
