# 🎬 Show Nexus: Event & Movie Booking Platform

**Show Nexus** is a full-featured **event and movie ticket booking system** designed to handle the end-to-end workflow of ticket management, user referrals, pricing, scheduling, and reporting in a scalable and normalized relational database architecture (BCNF-compliant).

---

## 🧠 Key Features

- 🔐 **User Management**: Register, login, and manage account details with role-based access (e.g., user, manager).
- 🎁 **Referral & Coupon System**: Users can refer others and earn discount coupons. Referral tracking is automated.
- 🎟️ **Event Booking**: Supports both movies and live shows with flexible scheduling and dynamic pricing.
- 🪑 **Seat Management**: Real-time tracking of available, booked, and empty seats by room, category, and show.
- 📊 **Analytics**: Revenue reports, peak booking hours, genre popularity, occupancy rates, and more.
- 🔔 **Notifications**: Schedule-based notification delivery system for booked events.
- 💰 **Payments**: Payment tracking with support for transaction IDs, multiple payment methods, and statuses.

---

## 🗂️ Database Structure

- **Normalized to BCNF** – ensures data consistency, removes redundancy.
- Schema: `Show_Nexus`

### 📌 Main Tables

| Table               | Description                                 |
|---------------------|---------------------------------------------|
| `Account`           | User profiles and referral management       |
| `Event`             | Base table for shows and movies             |
| `Event_Schedule`    | Date-time and venue association             |
| `Booking`           | Tracks all event bookings                   |
| `Seat`, `Room`      | Seat structure per room and venue           |
| `Show_Pricing`, `Movie_Pricing` | Dynamic pricing by category     |
| `Coupon`, `Coupon_Category`    | Discount management              |
| `Payment_Details`   | Payment method, amount, status tracking     |
| `Notification`, `User_Notifications` | Message delivery            |

---

## 🛠️ Technologies Used

- **PostgreSQL** (v14+)
- **pgAdmin** (for visualization and management)
- SQL (DDL + DML + Reporting queries)

---

## 🚀 How to Run

1. Clone this repository.
2. Launch **pgAdmin** and create a new schema named `Show_Nexus`.
3. Run the full DDL script provided in `DDL_Script.sql`.
4. Use the sample queries in `Queries.sql` to test and visualize your database.
5. Explore and expand with your own reports!

---

## 📊 Highlight SQL Queries

- ✅ **Available Seats per Movie**
- 🎟️ **Top 5 Most Booked Events**
- 💵 **Top Revenue-Generating Managers**
- 📍 **State-wise Booking Revenue**
- 📆 **Days with Peak Event Schedules**
- 🙌 **Most Active Referrers**

See `Queries.sql` for the full list (20 powerful insights).

---

## 📈 Example Use Case

> A user referred 3 friends and earned a ₹50 coupon. They booked a comedy show in Mumbai, selecting 3 gold-category seats. The system automatically calculated pricing, applied the coupon, recorded the payment, and notified the user 1 hour before the event.

---

## 🔄 Extensibility Ideas

- Add **multi-language support** for event descriptions
- Integrate with a **payment gateway API**
- Build a **React/Next.js frontend** with real-time seat selection
- Integrate **email/SMS notifications** using triggers

---

## 🧑‍💻 Maintainer

**Dhruvil Patel**  
Sophomore @ DAIICT |  
Batch Rep @ Programming Club  
CodeChef 4★ (1941) | Codeforces Specialist  
💼 [LinkedIn](https://www.linkedin.com/in/dhruvilpatel10) | 📫 dhruvilpatel217@gmail.com

---

## 📄 License

This project is intended for academic and educational use. Feel free to fork and build upon it.

---

