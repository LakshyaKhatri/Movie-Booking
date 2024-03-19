require_relative 'utils'

class Movie
  attr_reader :title

  # Skipping the following tasks to prevent scope creep:
  # - multiple shows on same timestamp
  def initialize(title:)
    @title = title.squeeze.strip.capitalize
    @genres = []
    @shows = {}
  end

  def genres
    @genres.dup
  end

  def add_genre(genre)
    validate_genre(genre)
    @genres << genre
  end

  def add_show(show_timing, rows, cols)
    show_timing = show_timing.upcase
    validate_show_timings(show_timing)

    # TODO: create and add a show
    @shows[show_timing] = Object.new
  end

  def show_timings
    @shows.keys
  end

  private

  def validate_genre(genre)
    return if Utils::ALL_GENRES.include?(genre)

    raise ArgumentError, "Invalid genre, please see data/genres.json for a complete list of genres"
  end

  def validate_show_timings(show_timing)
    begin
      DateTime.strptime(show_timing, "%I:%M %p")
    rescue ArgumentError
      raise ArgumentError, "Invalid show timings #{show_timing}, please use HH:MM AM/PM format"
    end

    raise ArgumentError, "A show already exists at #{show_timing} for this movie" if @shows.key?(show_timing)
  end
end
