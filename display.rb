# frozen_string_literal: true

require 'tty-table'

class String
  def black = "\033[30m#{self}\033[0m"
  def red = "\033[31m#{self}\033[0m"
  def green = "\033[32m#{self}\033[0m"
  def yellow = "\033[33m#{self}\033[0m"
  def blue = "\033[34m#{self}\033[0m"
  def magenta = "\033[35m#{self}\033[0m"
  def cyan = "\033[36m#{self}\033[0m"
  def gray = "\033[37m#{self}\033[0m"
  def underline = "\033[3;4m#{self}\033[0m"
end

class Display
  def print_welcome_message
    puts 'Welcome to MovieBooking.com!'.magenta.underline
    puts
  end

  def print_booking_success
    puts 'Thanks for booking with us!'
  end

  def print_cancel_booking_success
    puts 'Ticket Cancelled.'
  end

  def print_seat_status(theater)
    puts 'Booking Status:'

    table_rows = [
      ['Available Seats'.cyan, theater.available_seat_count.to_s.green],
      :separator,
      ['Booked Seats'.cyan, theater.booked_seat_count.to_s.red],
      :separator,
      ['Total Seats'.cyan, theater.total_seat_count.to_s.yellow]
    ]

    table = TTY::Table.new(table_rows)
    puts table.render(:unicode)
  end

  def print_seating(seats)
    table_rows = create_seating_table_rows(seats)

    table = TTY::Table.new(table_rows)
    puts "Seats marked with '#{'✗'.red}' are already booked."
    puts table.render(:unicode, alignment: [:center], resize: true)

    print_screen_boundary
  end

  def print_ticket(ticket)
    table_rows = [
      ['Movie:'.cyan, ticket.movie_title.magenta],
      :separator,
      ['Show Time:'.cyan, ticket.show_time.magenta],
      :separator,
      ['Seat Number:'.cyan, ticket.seat.magenta]
    ]

    table = TTY::Table.new(table_rows)
    puts "Here's your ticket:"
    puts table.render(:unicode)
  end

  private

  def create_seating_table_rows(seats)
    num_cols = seats['A'].to_a.length
    table_rows = []

    table_rows << ['', *(1..num_cols)]
    table_rows << :separator
    seats.each do |row_label, row_seats|
      table_rows << [row_label, *row_seats.map { |is_seat_reserved| is_seat_reserved ? '✗'.red : '-' }]
      table_rows << :separator
    end

    table_rows
  end

  def print_screen_boundary
    screen_table = TTY::Table.new([['───────────────SCREEN THIS SIDE───────────────']])
    puts screen_table.render(:unicode, alignment: [:center], resize: true)
    puts
  end
end
