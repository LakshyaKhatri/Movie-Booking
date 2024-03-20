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

  def reserve_seat(seat_label)
    @theater.mark_reserved(seat_label)
  end

  def cancel_seat(seat_label)
    @theater.mark_unreserved(seat_label)
  end

  def display_seat_status
    status = "Show Timing: #{@show_timing}\n"
    @seat_grid.each do |row|
      row.each do |seat|
        status += seat ? "O " : "X "  # O represents available seat, X represents booked seat
      end
      status += "\n"
    end
    return status
  end
end
