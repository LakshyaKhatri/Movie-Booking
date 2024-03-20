# frozen_string_literal: true

class ReservationError < StandardError; end

class SeatManagement
  attr_reader :total_seat_count, :available_seat_count, :booked_seat_count

  def initialize(num_rows, num_cols)
    @num_rows = num_rows
    @num_cols = num_cols
    @total_seat_count = num_cols * num_rows
    @available_seat_count = @total_seat_count
    @booked_seat_count = 0
    @seats = generate_seat_grid(@num_rows, @num_cols)
  end

  def seats
    @seats.dup
  end

  def generate_seat_grid(num_rows, num_cols)
    seats = {}
    end_label = generate_row_label(num_rows)

    ('A'..end_label).each do |row_label|
      seats[row_label] = [false] * num_cols # false represents an available seat
    end
    seats
  end

  def generate_row_label(row_index)
    # not too expensive: O(log(n) base 26)
    row_label = ''
    while row_index.positive?
      row_index -= 1
      row_label = (65 + (row_index % 26)).chr + row_label
      row_index /= 26
    end
    row_label
  end

  def mark_reserved(seat_label)
    row, col = extract_seat_position(seat_label)
    raise ArgumentError, 'Invalid seat label.' unless valid_seat_position?(row, col)
    raise ReservationError, "Seat #{seat_label} is already booked." if @seats[row][col]

    @seats[row][col] = true
    @available_seat_count -= 1
    @booked_seat_count += 1
  end

  def mark_unreserved(seat_label)
    row, col = extract_seat_position(seat_label)
    raise ArgumentError, 'Invalid seat label.' unless valid_seat_position?(row, col)
    raise ReservationError, "Seat #{seat_label} is already unreserved." unless @seats[row][col]

    @seats[row][col] = false
    @available_seat_count += 1
    @booked_seat_count -= 1
  end

  def extract_seat_position(seat_label)
    row = seat_label.delete('0123456789')
    col = seat_label[row.size..].to_i - 1
    [row, col]
  end

  def valid_seat_position?(row, col)
    @seats.key?(row) && col >= 0 && col < @num_cols
  end
end
