# NOTE: Theaters are local to a Show
class Theater
  def initialize(num_rows, num_cols)
    @num_rows = num_rows
    @num_cols = num_cols
    @seats = generate_seat_grid(num_rows, num_cols)
  end

  def generate_seat_grid(num_rows, num_cols)
    seats = {}
    ('A'..generate_row_label(num_rows)).each do |row_label|
      seats[row_label] = [false] * num_cols  # false represents an available seat
    end
    seats
  end

  def generate_row_label(row_index)
    row_label = ''
    while row_index > 0
      row_index -= 1
      row_label = (65 + (row_index % 26)).chr + row_label
      row_index /= 26
    end
    row_label
  end

  def mark_reserved(seat_label)
    row = seat_label.delete('0123456789')
    col = seat_label[row.size..-1].to_i - 1
    return 'Invalid seat label.' unless @seats.key?(row) && col >= 0 && col < @num_cols

    if @seats[row][col]
      "Seat #{seat_label} is already booked."
    else
      @seats[row][col] = true
      "Seat #{seat_label} has been booked."
    end
  end

  def mark_unreserved(seat_label)
    row = seat_label.delete('0123456789')
    col = seat_label[row.size..-1].to_i - 1
    return 'Invalid seat label.' unless @seats.key?(row) && col >= 0 && col < @num_cols

    if @seats[row][col]
      @seats[row][col] = false
      "Seat #{seat_label} has been un-booked."
    else
      "Seat #{seat_label} is already un-reserved."
    end
  end

  def display_seating
    max_col_width = @num_cols.to_s.length
    max_row_width = generate_row_label(@num_rows).length
    print '   '
    (1..@num_cols).each { |j| print "#{j.to_s.rjust(max_col_width)} " }
    puts
    @seats.each do |row_label, row_seats|
      print row_label.ljust(max_row_width), '  '
      row_seats.each { |seat_status| print seat_status ? 'X'.center(max_col_width) : '_'.center(max_col_width), ' ' }
      puts
    end
  end
end
