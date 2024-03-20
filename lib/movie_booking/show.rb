require_relative 'theater'

class Show
  attr_reader :movie, :show_timing

  def initialize(movie, show_timing, num_rows, num_cols)
    vaildate_movie(movie)
    @movie = movie

    show_timing.upcase!
    validate_show_timing(show_timing)
    @show_timing = show_timing

    # Future Iteration: allow API user's to assign shows to Theater of their choice
    @theater = Theater.new(num_rows, num_cols)
  end

  def reserve_seat(seat_label)
    @theater.mark_reserved(seat_label)
  end

  def cancel_seat(seat_label)
    @theater.mark_unreserved(seat_label)
  end

  def seats
    @theater.seats
  end

  private

  def vaildate_movie(movie)
    raise ArgumentError, "Invalid Movie Instance" unless movie.is_a? Movie
  end

  def validate_show_timing(show_timing)
    begin
      DateTime.strptime(show_timing, "%I:%M %p")
    rescue ArgumentError
      raise ArgumentError, "Invalid show timings #{show_timing}, please use HH:MM AM/PM format"
    end
  end
end
