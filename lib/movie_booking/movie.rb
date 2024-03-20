# frozen_string_literal: true

require 'titleize'
require_relative 'utils'
require_relative 'show'

class Movie
  attr_reader :title

  # Skipping the following tasks to prevent scope creep:
  # - multiple shows on same timestamp
  def initialize(title:)
    @title = title.squeeze.strip.titleize
    @genres = []
    @shows = []
  end

  def genres
    @genres.dup
  end

  def add_genre(genre)
    validate_genre(genre)
    @genres << genre
  end

  def show_timings
    @shows.map(&:show_timing)
  end

  def add_show(show)
    validate_show(show)
    @shows << show
  end

  private

  def validate_genre(genre)
    return if Utils::ALL_GENRES.include?(genre)

    raise ArgumentError, "Invalid genre, please see data/genres.json for a complete list of genres"
  end

  def validate_show(current_show)
    raise ArgumentError, "Invalid Show instance" unless current_show.is_a? Show
    raise ArgumentError, "A show already exists at #{show_timing} for this movie" if @shows.any? do |show|
      current_show.show_timing == show.show_timing
    end
  end
end
