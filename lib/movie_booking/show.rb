# frozen_string_literal: true

require_relative 'theater'
require 'date'

class Show
  attr_reader :movie, :time, :theater

  def initialize(movie:, time:, num_rows:, num_cols:)
    vaildate_movie(movie)
    @movie = movie

    time = time.upcase
    validate_time(time)
    @time = time

    # Future Iteration: allow API user's to assign shows to Theater of their choice
    @theater = Theater.new(num_rows, num_cols)
  end

  def reserve_seat(seat_label)
    @theater.mark_reserved(seat_label)
  end

  def cancel_seat(seat_label)
    @theater.mark_unreserved(seat_label)
  end

  private

  def vaildate_movie(movie)
    raise ArgumentError, 'Invalid Movie Instance' unless movie.is_a? Movie
  end

  def validate_time(time)
    DateTime.strptime(time, '%I:%M %p')
  rescue ArgumentError
    raise ArgumentError, "Invalid show time #{time}, please use HH:MM AM/PM format"
  end
end
