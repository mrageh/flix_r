module ReviewsHelper
  def format_average_star(movie)
    if movie.any_reviews?
      pluralize(number_with_precision(movie.average_stars, precision: 1) , 'star')
    else
      content_tag :p, "No Reviews"
    end
  end
end
