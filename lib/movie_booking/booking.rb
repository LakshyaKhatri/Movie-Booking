# frozen_string_literal: true

class Booking
  attr_reader :show, :seat, :user_full_name

  def initialize(show:, seat:, user_full_name:)
    @show = show
    @seat = seat
    @user_full_name = user_full_name

    reserve_seats
  end
end
