class BookingManager
  attr_reader :booking_indices

  def initialize
    @bookings = {}
    @booking_indices = {}
  end

  def add_booking(booking)
    show = booking.show
    movie = show.movie
    booking_description = "Seat ##{booking.seat} for #{movie.title} @ #{show.time}"
    @booking_indices[booking_description] = @bookings.length
    @bookings[@bookings.length] = booking

    @booking_indices[booking_description]
  end

  def delete_booking(booking_index)
    booking = @bookings.delete(booking_index)
    booking.cancel
    @booking_indices.delete_if { |_k, v| v == booking_index }

    booking
  end

  def get_booking(booking_index)
    @bookings[booking_index]
  end
end
