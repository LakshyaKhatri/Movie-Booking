# frozen_string_literal: true

# Not implementing following features to prevent scope creep:
# - reserving multiple seats in single booking
class Booking
  attr_reader :show, :seat

  def initialize(show:, seat:)
    @show = show
    @seat = seat

    reserve_seat
  end

  def reserve_seat
    @show.theater.reserve(@seat)
  end

  def ticket
    @ticket ||= Ticket.new(self)
  end

  def cancel
    @show.theater.unreserve(@seat)
  end
end
