# frozen_string_literal: true

require 'json'
require 'tty-prompt'
require 'movie_booking'

require_relative 'display'
require_relative 'booking_manager'

SHOW_TIMINGS = ['8:30 AM', '10:00 AM', '11:30 AM', '12:50 PM', '2:00 PM', '3:45 PM'].freeze
OPERATIONS = {
  "Book A Ticket": :book_ticket,
  "Cancel A Ticket": :cancel_ticket,
  "My Bookings": :list_bookings,
  "Movie Show Status": :movie_show_status,
  "Quit": :quit
}.freeze

class MovieBookingApp
  def initialize
    @prompt = TTY::Prompt.new
    @display = Display.new
    @movies = load_movies
    @operations = OPERATIONS
    @booking_manager = BookingManager.new
  end

  def run
    @display.print_welcome_message
    loop do
      @prompt.keypress('press any key to continue...')
      print("\e[2J\e[f") # clear screen
      selected_operation = @prompt.select('How can we help?', @operations)

      send(selected_operation)
    end
  end

  private

  def load_movies
    movie_file = File.join(File.dirname(__FILE__), 'data/movies.json')
    movies_json_array = JSON.load_file(movie_file, symbolize_names: true)

    movies_json_array.each_with_object({}) do |movie_json, movies|
      movie = Movie.new(title: movie_json[:title])
      movie_json[:genres].each do |genre|
        movie.add_genre(genre)
      end

      SHOW_TIMINGS.each do |time|
        show = Show.new(movie:, time:, num_rows: rand(5..8), num_cols: rand(5..8))
        movie.add_show(show)
      end

      movies[movie.title] = movie
    end.freeze
  end

  def book_ticket
    movie = @prompt.select('Which movie you want to see?', @movies, filter: true)
    show = @prompt.select('Which show you want a ticket for?', movie.shows, filter: true)
    theater = show.theater

    @display.print_seat_status(theater)
    @display.print_seating(theater.seats)
    seat_label = @prompt.ask('Please enter the label for the seat you want to book:', required: true) do |q|
      q.validate ->(seat_label) { theater.valid_seat_position?(seat_label) && !theater.seat_reserved?(seat_label) }
      q.messages[:valid?] = "Invalid seat label %{value}. Please choose an available seat label from the seats displayed."
    end

    booking = Booking.new(show: show, seat: seat_label)
    @booking_manager.add_booking(booking)
    @display.print_booking_success
    @display.print_ticket(booking.ticket)
  end

  def cancel_ticket
    booking_index = @prompt.select('Which ticket do you want to cancel?', @booking_manager.booking_indices, filter: true)
    return if @prompt.no?('Are you sure you want to cancel this ticket?')

    @booking_manager.delete_booking(booking_index)
    @display.print_cancel_booking_success
  end

  def list_bookings
    booking_index = @prompt.select('Select a ticket to see more details?', @booking_manager.booking_indices, filter: true)
    booking = @booking_manager.get_booking(booking_index)
    @display.print_ticket(booking.ticket)
  end

  def movie_show_status
    movie = @prompt.select('Select a movie first', @movies, filter: true)
    show = @prompt.select('Which show you want to check?', movie.shows, filter: true)
    theater = show.theater

    @display.print_seat_status(theater)
    @display.print_seating(theater.seats)
  end

  def quit

    exit(0)
  end
end


app = MovieBookingApp.new
app.run
