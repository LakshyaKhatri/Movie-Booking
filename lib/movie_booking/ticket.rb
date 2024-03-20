# frozen_string_literal: true

class Ticket
  attr_reader :show, :seat_number, :user_full_name

  def initialize(show, seat_number, user_full_name)
    @show = show
    @seat_number = seat_number
    @user_full_name = user_full_name
  end
end
