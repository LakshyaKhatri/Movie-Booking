# frozen_string_literal: true

require_relative 'seat_management'

# NOTE: Theater is local to a Show
class Theater
  def initialize(num_rows, num_cols)
    @seat_management = SeatManagement.new(num_rows, num_cols)
  end

  # delegated methods
  def seats
    @seat_management.seats
  end

  def available_seat_count
    @seat_management.available_seat_count
  end

  def booked_seat_count
    @seat_management.booked_seat_count
  end

  def total_seat_count
    @seat_management.total_seat_count
  end

  def valid_seat_position?(seat_label)
    row, col = @seat_management.extract_seat_position(seat_label)

    @seat_management.valid_seat_position?(row, col)
  end

  def seat_reserved?(seat_label)
    row, col = @seat_management.extract_seat_position(seat_label)

    @seat_management.reserved?(row, col)
  end
end
