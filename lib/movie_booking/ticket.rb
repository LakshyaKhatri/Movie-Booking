# frozen_string_literal: true

class Ticket
  attr_reader :movie_title, :show_time, :seat

  def initialize(booking)
    @movie_title = booking.show.movie.title
    @show_time = booking.show.time
    @seat = booking.seat
  end
end
