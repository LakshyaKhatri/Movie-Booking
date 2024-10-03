# Movie Booking

A terminal based movie booking library


## Screnshots
<img width="1121" alt="image" src="https://github.com/user-attachments/assets/b123ea7e-0a3a-4652-a827-33bf93d35fab">



## Installation

```sh
git clone https://github.com/LakshyaKhatri/Movie-Booking.git && cd Movie-Booking
gem build movie_booking
gem install --local movie_booking-0.0.1.gem
```

## Usage

**App Runner:** If you just want to use the movie booking system you can use the runner file:

```sh
ruby app.rb # make sure you have ruby >= 3.0.0
```

**Gem Library:** If you want to integrate it with your custom use case, you can check the file inside `lib/` and use the classes as per your need.

## Problem Statement

### Movie Initialization

- Define a list of available movies with details such as title, genre, and show timings.

### User Booking:

- Implement a method for users to book tickets for a specific movie and showtime.
- Keep track of the number of available seats for each show.

### Seat Allocation:

- When a user books a ticket, allocate the next available seat for the chosen show.

### Ticket Cancellation:

- Implement a method for users to cancel their booked tickets.
- Make the canceled seats available for booking again.

### Booking Confirmation and Display:

- Provide a booking confirmation with details such as movie title, showtime, and seat number.
- Display the current status of booked and available seats for each show.

### Multiple Movies and Shows:

- Extend the system to support multiple movies with different show timings.

