# frozen_string_literal: true

require 'tty-table'

class String
  def black;          "\033[30m#{self}\033[0m" end
  def red;            "\033[31m#{self}\033[0m" end
  def green;          "\033[32m#{self}\033[0m" end
  def yellow;         "\033[33m#{self}\033[0m" end
  def blue;           "\033[34m#{self}\033[0m" end
  def magenta;        "\033[35m#{self}\033[0m" end
  def cyan;           "\033[36m#{self}\033[0m" end
  def gray;           "\033[37m#{self}\033[0m" end
  def underline;         "\033[3;4m#{self}\033[0m" end
end

class Display
  def print_welcome_message
    puts 'Welcome to MovieBooking.com!'.magenta.underline
    puts
  end

  def print_booking_success
    puts "Thanks for booking with us!"
  end

  def print_cancel_booking_success
    puts "Ticket Cancelled."
  end

  def print_seat_status(theater)
    puts "Booking Status:"

    table_rows = []
    table_rows << ['Available Seats'.cyan, theater.available_seat_count.to_s.green]
    table_rows << :separator
    table_rows << ['Booked Seats'.cyan, theater.booked_seat_count.to_s.red]
    table_rows << :separator
    table_rows << ['Total Seats'.cyan, theater.total_seat_count.to_s.yellow]

    table = TTY::Table.new(table_rows)
    puts table.render(:unicode)
  end

  def print_seating(seats)
    num_cols = seats.dig('A').to_a.length

    table_rows = []
    table_rows << [''] + (1..num_cols).to_a
    table_rows << :separator
    seats.each do |row_label, row_seats|
      row = [row_label]
      row.concat(row_seats.map { |is_seat_reserved| is_seat_reserved ? '✗'.red : '-' })
      table_rows << row
      table_rows << :separator
    end

    table = TTY::Table.new(table_rows)
    puts "Seats marked with '#{'✗'.red}' are already booked."
    puts table.render(:unicode, alignment: [:center], resize: true)

    screen_table = TTY::Table.new([['───────────────SCREEN THIS SIDE───────────────']])
    puts screen_table.render(:unicode, alignment: [:center], resize: true)
    puts
  end

  def print_ticket(ticket)
    table_rows = []
    table_rows << ["Movie:".cyan, ticket.movie_title.magenta]
    table_rows << :separator
    table_rows << ["Show Time:".cyan, ticket.show_time.magenta]
    table_rows << :separator
    table_rows << ["Seat Number:".cyan, ticket.seat.magenta]

    table = TTY::Table.new(table_rows)
    puts "Here's your ticket:"
    puts table.render(:unicode)
  end
end
