# frozen_string_literal: true

require_relative 'seat_management'
require_relative 'utils'

# NOTE: Theater is local to a Show
class Theater
  def initialize(num_rows, num_cols)
    @seat_management = SeatManagement.new(num_rows, num_cols)
  end

  # delegated methods
  def seats
    @seat_management.seats
  end
end
