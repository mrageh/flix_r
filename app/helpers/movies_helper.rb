module MoviesHelper
  def format_total_gross(movie)
    if movie.flop?
      "Flop!"
    else
      number_to_currency(movie.total_gross)
    end
  end

  def image_for(movie)
    if movie.image_blank?
      image_tag "placeholder.png"
    else
      image_tag movie.image_file_name
    end
  end
end
