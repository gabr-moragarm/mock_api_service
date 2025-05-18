# frozen_string_literal: true

require 'sinatra/base'
require 'json'
require 'faker'

module Routes
  class ApiJsonBasic < Sinatra::Base


    STATUS = %w[Tentative Inserted Confirmed Checkin Checkout NoShow Canceled Option InHouse].freeze
    CHANNELS = %w[Direct ChanneManager Website Walkin TourOperator GDS Booking.com Expedia Airbnb Telephone].freeze
    MARKETS = %w[Retail Group Business Leisure BusinessGroup Congress].freeze

    # Frozen list of supported hotel rate codes.
    # These are used to identify pricing rules across channels, segments, and booking conditions.
    RATE_CODES = [
      # Simple leisure-oriented rate codes
      :FLEX,         # Flexible rate, free cancellation
      :NONREF,       # Non-refundable rate
      :EARLY,        # Early booking discount
      :LASTMIN,      # Last-minute offer
      :WEEKEND,      # Weekend special
      :NIGHT2,       # Minimum 2-night stay
      :NIGHT3BF,     # 3-night stay with breakfast
      :SOLO,         # Single traveler rate
      :COUPLE,       # Couple offer
      :FAMILY,       # Family package
      :KIDSFREE,     # Free stay for children
      :PETSOK,       # Pet-friendly rate
      :BNB,          # Bed & Breakfast
      :RO,           # Room only
      :HALFBOARD,    # Half board (breakfast + dinner)
      :FULLBOARD,    # Full board (all meals)
      :MOBILE,       # Mobile booking exclusive
      :DIRECT,       # Direct booking discount

      # Structured and corporate rate codes
      :BARSTD,       # Best Available Rate - Standard
      :BARADV,       # Best Available Rate - Advance Purchase
      :CORWEB01,     # Corporate web rate
      :COROTAB02,    # Corporate OTA rate
      :LOMIN3N,      # Long stay (min 3 nights)
      :LO7NREF,      # Long stay (7 nights, non-refundable)
      :NONREFWEB,    # Web-exclusive non-refundable rate
      :WALKINSTD,    # Walk-in standard rate
      :GRPCONF01,    # Group/conference rate
      :PKGBRKFST,    # Package with breakfast
      :PKGFAM02,     # Family package 2+1
      :VIPSUITE,     # VIP suite exclusive
      :STAFFINT,     # Internal staff rate
      :OTAEXPEDIA,   # Expedia OTA rate
      :OTABKGSTD,    # Booking.com standard rate
      :MOBILEAPP     # App-only special rate
    ].freeze

    BOARDS = %w[RO BB HB FB AI].freeze

    # Frozen list of supported room types.
    # Used for inventory management, pricing, and channel mapping.
    ROOM_TYPES = [
      :SGL,          # Single room
      :DBL,          # Double room (1 bed)
      :TWN,          # Twin room (2 separate beds)
      :TRP,          # Triple room
      :QUAD,         # Quadruple room
      :DBLDBL,       # Double-double (2 double beds)
      :KING,         # King bed room
      :QUEEN,        # Queen bed room
      :SUITE,        # Standard suite
      :JRSUITE,      # Junior suite
      :STUDIO,       # Studio room with kitchenette
      :FAMILY,       # Family room (configurable)
      :ADJOIN,       # Adjoining/connecting rooms
      :ACCESS,       # Accessible room
      :ECONOMY,      # Economy/basic room
      :SUPERIOR,     # Superior room
      :DELUXE,       # Deluxe room
      :EXEC,         # Executive room
      :PENTHOUSE,    # Penthouse suite
      :VILLA,        # Private villa
      :BUNGALOW,     # Independent bungalow
      :DORM,         # Dormitory/shared room
      :CAMPER,       # Camper pitch / mobile accommodation
      :TENT          # Tent / glamping unit
    ].freeze

    # TODO: Authentication

    get '/api/json/basic/reservations' do
      # TODO: Validation

      content_type :json

      response_body = []
      (1..rand(25..50)).each do |n|
        response_body << {
          id: n,
          status: STATUS.sample,
          channel: CHANNELS.sample,
          market: MARKETS.sample,
          rateCode: RATE_CODES.sample,
          board: BOARDS.sample,
          nationality: Faker::Nation.nationality,
          created_at: Faker::Time.between(from: DateTime.now - 800, to: DateTime.now),
          arrival_date: Faker::Date.between(from: Date.today - 365, to: Date.today + 365),
          departure_date: Faker::Date.between(from: Date.today - 365, to: Date.today + 365),
          cancellated_at: rand(1..2).odd? ? nil : Faker::Time.between(from: DateTime.now - 800, to: DateTime.now),
          sold_rooms: rand(1..5),
          full_revenue: rand(10.0..300.0),
          extra_revenue: rand(10.0..300.0),
          rooms_revenue: rand(10.0..300.0),
          guests: rand(0..10),
          room_type: ROOM_TYPES.sample
        }
      end

      response_body.to_json
    end
  end
end
