-- DDL SCRIPT FOR Show_Nexus (BCNF-Compliant)
create schema Show_Nexus;
set search_path to Show_Nexus;

CREATE TABLE Account (
    account_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    mobile_number VARCHAR(10) NOT NULL,
    dateofbirth DATE,
    gender VARCHAR(10),
    role DECIMAL(1,0) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    state VARCHAR(50),
    city VARCHAR(50),
    area VARCHAR(50),
    firstname VARCHAR(50) NOT NULL,
    middlename VARCHAR(50),
    surname VARCHAR(50) NOT NULL,
    referral_code VARCHAR(20) UNIQUE,
    referred_by INT,
    FOREIGN KEY (referred_by) REFERENCES Account(account_id)
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Coupon_Category (
    coupon_category_id INT PRIMARY KEY,
    category_name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE Coupon (
    coupon_id INT PRIMARY KEY,
    account_id INT NOT NULL,
    coupon_category_id INT NOT NULL,
    amount DECIMAL(8,2) NOT NULL,
    validity DATE NOT NULL,
    issued_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    redeemed_at TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (coupon_category_id) REFERENCES Coupon_Category(coupon_category_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Event (
    event_id INT PRIMARY KEY,
    event_name VARCHAR(100) NOT NULL,
    event_description TEXT,
    poster_link TEXT,
    trailer_link TEXT,
    duration TIME,
    age_restriction INT,
    language VARCHAR(50),
    event_genre VARCHAR(50)
);

CREATE TABLE Movie_Event (
    event_id INT PRIMARY KEY,
    imdb_rating DECIMAL(3,1),
    release_date DATE,
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Show_Event (
    event_id INT PRIMARY KEY,
    audience_interaction BOOLEAN,
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Artist (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL
);

CREATE TABLE Show_Performers (
    artist_id INT,
    event_id INT,
    PRIMARY KEY (artist_id, event_id),
    FOREIGN KEY (artist_id) REFERENCES Artist(artist_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (event_id) REFERENCES Show_Event(event_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Region (
    pincode INT PRIMARY KEY,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    area VARCHAR(50) NOT NULL
);

CREATE TABLE Venue (
    venue_id INT PRIMARY KEY,
    venue_name VARCHAR(100) NOT NULL,
    pincode INT NOT NULL,
    FOREIGN KEY (pincode) REFERENCES Region(pincode)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Room (
    room_id INT PRIMARY KEY,
    venue_id INT NOT NULL,
    room_no INT NOT NULL,
    screen_type VARCHAR(50),
    capacity INT NOT NULL,
    FOREIGN KEY (venue_id) REFERENCES Venue(venue_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Category (
    catagory VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Seat (
    room_id INT,
    seat_number VARCHAR(10),
    seat_row INT,
    catagory VARCHAR(50),
    PRIMARY KEY (room_id, seat_number),
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (catagory) REFERENCES Category(catagory)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Event_Schedule (
    schedule_id INT PRIMARY KEY,
    event_id INT NOT NULL,
    manager_id INT NOT NULL,
    room_id INT NOT NULL,
    event_datetime TIMESTAMP NOT NULL,
    sponsored_money DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (event_id) REFERENCES Event(event_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (manager_id) REFERENCES Account(account_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (room_id) REFERENCES Room(room_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Notification (
    notification_id INT PRIMARY KEY,
    schedule_id INT,
    message TEXT,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (schedule_id) REFERENCES Event_Schedule(schedule_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE User_Notifications (
    account_id INT,
    notification_id INT,
    PRIMARY KEY (account_id, notification_id),
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (notification_id) REFERENCES Notification(notification_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Show_Pricing (
    schedule_id INT,
    category VARCHAR(50),
    category_capacity INT,
    price DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (schedule_id, category),
    FOREIGN KEY (schedule_id) REFERENCES Event_Schedule(schedule_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (category) REFERENCES Category(catagory)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Movie_Pricing (
    schedule_id INT,
    catagory VARCHAR(50),
    price DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (schedule_id, catagory),
    FOREIGN KEY (schedule_id) REFERENCES Event_Schedule(schedule_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (catagory) REFERENCES Category(catagory)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Payment_Details (
    payment_id INT PRIMARY KEY,
    transaction_id VARCHAR(100) UNIQUE,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    payment_amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Booking (
    booking_id INT PRIMARY KEY,
    schedule_id INT NOT NULL,
    account_id INT NOT NULL,
    payment_id INT NOT NULL,
    review TEXT,
    booking_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Account(account_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (schedule_id) REFERENCES Event_Schedule(schedule_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (payment_id) REFERENCES Payment_Details(payment_id)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Booking_Show (
    booking_id INT PRIMARY KEY,
    catagory VARCHAR(50) NOT NULL,
    seat_count INT NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (catagory) REFERENCES Category(catagory)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE Booking_Movie (
    booking_id INT,
    seat_number VARCHAR(10) NOT NULL,
    catagory VARCHAR(50) NOT NULL,
    PRIMARY KEY (booking_id, seat_number),
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (catagory) REFERENCES Category(catagory)
        ON DELETE RESTRICT ON UPDATE CASCADE
);
