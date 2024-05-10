module MovieHelper
  def movie_genre_names(movie)
    movie[:genres].map { |genre| genre[:name] }.join(", ")
  end

  def format_runtime(minutes)
    hours = minutes / 60
    remaining_minutes = minutes % 60

    if hours > 0 && remaining_minutes > 0
      "#{hours} hours, #{remaining_minutes} minutes"
    elsif hours > 0
      "#{hours} hours"
    else
      "#{remaining_minutes} minutes"
    end

  end
end