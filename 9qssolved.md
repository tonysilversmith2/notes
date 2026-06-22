Here are the full Python implementations for each of the 9 class-design problems outlined in the workbook. Every class is complete with its constructor, internal data structures, logic, and data validation rules specified in the constraints.
## Question 1: Employee Attendance System
This system handles basic HR analytics tracking daily presence ("P") and absence ("A").
```python
class EmployeeAttendanceSystem:

    def __init__(self, attendance=None):
        # [span_12](start_span)Store provided dictionary or initialize a new empty one[span_12](end_span)
        if attendance is not None:
            self.attendance = attendance
        else:
            self.attendance = {}

    def add_attendance(self, employee, status):
        # [span_13](start_span)Initialize list if employee is not found, then append status[span_13](end_span)
        if employee not in self.attendance:
            self.attendance[employee] = []
        self.attendance[employee].append(status)

    def perfect_attendance(self):
        # [span_14](start_span)Filter for employees whose records do not contain any "A"[span_14](end_span)
        perfect = []
        for employee, statuses in self.attendance.items():
            if "A" not in statuses:
                perfect.append(employee)
        return perfect

    def absent_count(self, employee):
        # [span_15](start_span)Return count of absences or 0 if employee does not exist[span_15](end_span)
        if employee in self.attendance:
            return self.attendance[employee].count("A")
        return 0

    def attendance_percentage(self):
        percentages = {}
        for employee, statuses in self.attendance.items():
            if not statuses:
                percentages[employee] = 0.00
                continue
            # (present days / total days) * [span_16](start_span)100 rounded to 2 decimal places[span_16](end_span)
            p_count = statuses.count("P")
            pct = (p_count / len(statuses)) * 100
            percentages[employee] = round(pct, 2)
        return percentages

    def highest_attendance_employee(self):
        percentages = self.attendance_percentage()
        if not percentages:
            return None
        
        highest_emp = None
        highest_val = -1.0
        
        # [span_17](start_span)Tie-breaker: returns the first encountered in order[span_17](end_span)
        for employee, pct in percentages.items():
            if pct > highest_val:
                highest_val = pct
                highest_emp = employee
        return highest_emp

```
## Question 2: Inventory Management System
Tracks product quantity and per-unit prices across retail inventory.
```python
class InventoryManagementSystem:

    def __init__(self, inventory=None):
        if inventory is not None:
            self.inventory = inventory
        else:
            self.inventory = {}

    def add_product(self, product, quantity, price):
        # [span_19](start_span)Add new product or replace existing values[span_19](end_span)
        self.inventory[product] = {"quantity": quantity, "price": price}

    def update_stock(self, product, quantity):
        # [span_20](start_span)Accumulates directly onto existing stock[span_20](end_span)
        if product in self.inventory:
            self.inventory[product]["quantity"] += quantity

    def inventory_value(self):
        # [span_21](start_span)Sum of quantity * price across all tracked units[span_21](end_span)
        total_val = 0
        for item in self.inventory.values():
            total_val += item["quantity"] * item["price"]
        return total_val

    def low_stock_products(self, threshold):
        # [span_22](start_span)Strictly less than target threshold[span_22](end_span)
        return [
            name
            for name, item in self.inventory.items()
            if item["quantity"] < threshold
        ]

    def most_stocked_product(self):
        if not self.inventory:
            return None
        # [span_23](start_span)Evaluates the highest single item count[span_23](end_span)
        return max(self.inventory, key=lambda k: self.inventory[k]["quantity"])

    def total_products(self):
        return len(self.inventory)

```
## Question 3: Hospital Appointment System
Aggregates structured medical scheduling records containing patient names, doctor names, and schedule dates.
```python
class HospitalAppointmentSystem:

    def __init__(self, appointments=None):
        if appointments is not None:
            self.appointments = appointments
        else:
            self.appointments = []

    def add_appointment(self, patient, doctor, date):
        # [span_25](start_span)Store as standard immutable tuple[span_25](end_span)
        self.appointments.append((patient, doctor, date))

    def doctor_workload(self):
        workload = {}
        for _, doctor, _ in self.appointments:
            workload[doctor] = workload.get(doctor, 0) + 1
        return workload

    def patient_visit_count(self):
        visits = {}
        for patient, _, _ in self.appointments:
            visits[patient] = visits.get(patient, 0) + 1
        return visits

    def multi_doctor_patients(self):
        # Collect distinct unique doctors seen per patient entity
        patient_doctors = {}
        for patient, doctor, _ in self.appointments:
            if patient not in patient_doctors:
                patient_doctors[patient] = set()
            patient_doctors[patient].add(doctor)

        # [span_26](start_span)Return set of patients with more than one unique doctor[span_26](end_span)
        return {
            patient
            for patient, docs in patient_doctors.items()
            if len(docs) > 1
        }

    def busiest_doctor(self):
        workload = self.doctor_workload()
        if not workload:
            return None
        # [span_27](start_span)Returns first encountered element in case of matching workloads[span_27](end_span)
        return max(workload, key=workload.get)

    def appointments_on_date(self, date):
        # [span_28](start_span)Exact string match filter against input date[span_28](end_span)
        return [appt for appt in self.appointments if appt[2] == date]

```
## Question 4: Digital Wallet System
Handles monetary balances, peer transfers, safety guardrails against negative fields, and audit histories.
```python
class DigitalWalletSystem:

    def __init__(self):
        self.wallets = {}
        self.transactions = {}

    def create_wallet(self, user):
        if user not in self.wallets:
            self.wallets[user] = 0
            self.transactions[user] = []

    def deposit(self, user, amount):
        if user in self.wallets:
            self.wallets[user] += amount
            [span_30](start_span)self.transactions[user].append(("Deposit", amount))[span_30](end_span)

    def withdraw(self, user, amount):
        if user in self.wallets:
            # [span_31](start_span)Prevent operational balance drops below zero[span_31](end_span)
            if self.wallets[user] >= amount:
                self.wallets[user] -= amount
                [span_32](start_span)self.transactions[user].append(("Withdraw", amount))[span_32](end_span)

    def transfer(self, sender, receiver, amount):
        if sender in self.wallets and receiver in self.wallets:
            # [span_33](start_span)[span_34](start_span)Verify sender can clear full transfer total amount safely[span_33](end_span)[span_34](end_span)
            if self.wallets[sender] >= amount:
                self.wallets[sender] -= amount
                self.wallets[receiver] += amount
                [span_35](start_span)self.transactions[sender].append(("Transfer Out", amount))[span_35](end_span)
                [span_36](start_span)self.transactions[receiver].append(("Transfer In", amount))[span_36](end_span)

    def current_balance(self, user):
        return self.wallets.get(user, 0)

    def transaction_history(self, user):
        return self.transactions.get(user, [])

    def total_deposits(self):
        total = 0
        for tx_list in self.transactions.values():
            for tx_type, amount in tx_list:
                # [span_37](start_span)Exclude 'Transfer In' events per specifications[span_37](end_span)
                if tx_type == "Deposit":
                    total += amount
        return total

    def highest_balance_holder(self):
        if not self.wallets:
            return None
        return max(self.wallets, key=self.wallets.get)

```
## Question 5: Online Shopping Cart System
Manages nested individual buyer carts, calculating item quantities and localized analytics.
```python
class OnlineShoppingCartSystem:

    def __init__(self, carts=None):
        if carts is not None:
            self.carts = carts
        else:
            self.carts = {}

    def add_to_cart(self, customer, product, price, quantity):
        if customer not in self.carts:
            self.carts[customer] = {}

        if product in self.carts[customer]:
            # [span_39](start_span)Add to quantity if item already exists[span_39](end_span)
            self.carts[customer][product]["quantity"] += quantity
        else:
            self.carts[customer][product] = {
                "price": price,
                "quantity": quantity,
            }

    def remove_from_cart(self, customer, product):
        if customer in self.carts and product in self.carts[customer]:
            del self.carts[customer][product]

    def cart_items(self, customer):
        if customer in self.carts:
            return list(self.carts[customer].keys())
        return []

    def total_cart_value(self, customer):
        total = 0
        if customer in self.carts:
            for item in self.carts[customer].values():
                [span_40](start_span)total += item["price"] * item["quantity"][span_40](end_span)
        return total

    def total_items(self, customer):
        total = 0
        if customer in self.carts:
            for item in self.carts[customer].values():
                [span_41](start_span)total += item["quantity"][span_41](end_span)
        return total

    def most_expensive_product(self, customer):
        if customer not in self.carts or not self.carts[customer]:
            return None
        # [span_42](start_span)Checks base unit price, ignoring calculated line totals[span_42](end_span)
        return max(
            self.carts[customer], key=lambda p: self.carts[customer][p]["price"]
        )

    def active_customers(self):
        # [span_43](start_span)Customers who have at least one product in their cart dictionary[span_43](end_span)
        return [cust for cust, items in self.carts.items() if len(items) > 0]

    def product_popularity(self):
        popularity = {}
        for customer_cart in self.carts.values():
            for prod_name, info in customer_cart.items():
                popularity[prod_name] = (
                    [span_44](start_span)popularity.get(prod_name, 0) + info["quantity"][span_44](end_span)
                )
        return popularity

```
## Question 6: Movie Streaming Platform
Performs aggregation on consumption behaviors and metric-driven media library rankings.
```python
class MovieStreamingPlatform:

    def __init__(self):
        self.watch_history = {}
        self.ratings = {}

    def watch_movie(self, user, movie, duration):
        if user not in self.watch_history:
            self.watch_history[user] = []
        [span_47](start_span)self.watch_history[user].append((movie, duration))[span_47](end_span)

    def rate_movie(self, movie, rating):
        if movie not in self.ratings:
            self.ratings[movie] = []
        self.ratings[movie].append(rating)

    def movies_watched_by_user(self, user):
        if user not in self.watch_history:
            return []
        # Return unique set or chronological listed items depending on user criteria
        # Extracted matches list order format requirement:
        return [movie for movie, _ in self.watch_history[user]]

    def total_watch_time(self, user):
        if user not in self.watch_history:
            return 0
        [span_48](start_span)return sum(dur for _, dur in self.watch_history[user])[span_48](end_span)

    def movie_view_count(self):
        counts = {}
        for user_history in self.watch_history.values():
            for movie, _ in user_history:
                [span_49](start_span)counts[movie] = counts.get(movie, 0) + 1[span_49](end_span)
        return counts

    def average_rating(self, movie):
        if movie not in self.ratings or not self.ratings[movie]:
            return 0.0
        # [span_50](start_span)Rounded precisely down to 2 places[span_50](end_span)
        return round(sum(self.ratings[movie]) / len(self.ratings[movie]), 2)

    def most_watched_movie(self):
        counts = self.movie_view_count()
        if not counts:
            return None
        return max(counts, key=counts.get)

    def top_rated_movie(self):
        if not self.ratings:
            return None
        # Map average computing metrics out cleanly to look up the max ranking title
        avg_ratings = {
            movie: self.average_rating(movie) for movie in self.ratings
        }
        return max(avg_ratings, key=avg_ratings.get)

```
## Question 7: Gaming Tournament Management System
Tracks leaderboard records across several distinct multiplayer video games.
```python
class GamingTournamentSystem:

    def __init__(self):
        self.tournament_records = {}

    def add_result(self, player, game, points):
        if player not in self.tournament_records:
            self.tournament_records[player] = []
        [span_52](start_span)self.tournament_records[player].append((game, points))[span_52](end_span)

    def tournaments_played(self, player):
        return len(self.tournament_records.get(player, []))

    def total_points(self, player):
        [span_53](start_span)return sum(pts for _, pts in self.tournament_records.get(player, []))[span_53](end_span)

    def average_points(self, player):
        records = self.tournament_records.get(player, [])
        if not records:
            return 0.0
        [span_54](start_span)return round(self.total_points(player) / len(records), 2)[span_54](end_span)

    def leaderboard(self):
        board = []
        for player in self.tournament_records:
            board.append((player, self.total_points(player)))
        # [span_55](start_span)Sort values from highest to lowest points[span_55](end_span)
        board.sort(key=lambda x: x[1], reverse=True)
        return board

    def top_player(self):
        leaderboard_data = self.leaderboard()
        if not leaderboard_data:
            return None
        [span_56](start_span)return leaderboard_data[0][0][span_56](end_span)

    def players_in_multiple_games(self):
        multi_game_players = set()
        for player, games_list in self.tournament_records.items():
            distinct_games = {game for game, _ in games_list}
            if len(distinct_games) > 1:
                [span_57](start_span)multi_game_players.add(player)[span_57](end_span)
        return multi_game_players

    def game_popularity(self):
        counts = {}
        for games_list in self.tournament_records.values():
            for game, _ in games_list:
                [span_58](start_span)counts[game] = counts.get(game, 0) + 1[span_58](end_span)
        return counts

```
## Question 8: University Course Feedback System
Tracks university end-of-semester course ratings and free-text critique arrays.
```python
class UniversityCourseFeedbackSystem:

    def __init__(self):
        self.feedback_records = {}

    def submit_feedback(self, student, course, rating, comment):
        if student not in self.feedback_records:
            self.feedback_records[student] = []
        [span_60](start_span)self.feedback_records[student].append((course, rating, comment))[span_60](end_span)

    def courses_reviewed_by_student(self, student):
        return [
            course for course, _, _ in self.feedback_records.get(student, [])
        ]

    def feedback_count_per_course(self):
        counts = {}
        for record_list in self.feedback_records.values():
            for course, _, _ in record_list:
                [span_61](start_span)counts[course] = counts.get(course, 0) + 1[span_61](end_span)
        return counts

    def average_course_rating(self, course):
        total_rating = 0
        count = 0
        for record_list in self.feedback_records.values():
            for c_name, rating, _ in record_list:
                if c_name == course:
                    total_rating += rating
                    count += 1
        if count == 0:
            return 0.0
        [span_62](start_span)return round(total_rating / count, 2)[span_62](end_span)

    def highest_rated_course(self):
        counts = self.feedback_count_per_course()
        if not counts:
            return None
        # [span_63](start_span)[span_64](start_span)Look up course with maximum relative score average[span_63](end_span)[span_64](end_span)
        return max(counts, key=self.average_course_rating)

    def students_reviewing_multiple_courses(self):
        students = set()
        for student, records in self.feedback_records.items():
            distinct_courses = {course for course, _, _ in records}
            if len(distinct_courses) > 1:
                [span_65](start_span)students.add(student)[span_65](end_span)
        return students

    def overall_university_rating(self):
        total_rating = 0
        count = 0
        for record_list in self.feedback_records.values():
            for _, rating, _ in record_list:
                total_rating += rating
                count += 1
        if count == 0:
            return 0.0
        [span_66](start_span)[span_67](start_span)return round(total_rating / count, 2)[span_66](end_span)[span_67](end_span)

    def course_comments(self, course):
        comments = []
        for record_list in self.feedback_records.values():
            for c_name, _, comment in record_list:
                if c_name == course:
                    [span_68](start_span)comments.append(comment)[span_68](end_span)
        return comments

```
## Question 9: Loan Management System
Monitors financial debt profiles, tracking active versus closed loans across consumers.
```python
 class LoanManagementSystem:

    def __init__(self):
        self.loans = {}

    def add_loan(self, customer, loan_id, loan_type, amount, status):
        if customer not in self.loans:
            self.loans[customer] = []
        [span_70](start_span)self.loans[customer].append((loan_id, loan_type, amount, status))[span_70](end_span)

    def customer_total_loans(self, customer):
        # [span_71](start_span)Includes both active and closed loan items[span_71](end_span)
        return sum(amount for _, _, amount, _ in self.loans.get(customer, []))

    def active_loans(self, customer):
        # [span_72](start_span)Filters strictly on matching status checks[span_72](end_span)
        return [
            loan
            for loan in self.loans.get(customer, [])
            if loan[3] == "Active"
        ]

    def total_outstanding_amount(self):
        total = 0
        for loan_list in self.loans.values():
            for _, _, amount, status in loan_list:
                if status == "Active":
                    [span_73](start_span)total += amount[span_73](end_span)
        return total

    def highest_borrower(self):
        if not self.loans:
            return None
        # [span_74](start_span)Evaluates structural aggregate across active and closed entries[span_74](end_span)
        return max(self.loans, key=self.customer_total_loans)

    def loan_type_distribution(self):
        distribution = {}
        for loan_list in self.loans.values():
            for _, loan_type, _, _ in loan_list:
                [span_75](start_span)distribution[loan_type] = distribution.get(loan_type, 0) + 1[span_75](end_span)
        return distribution

    def average_loan_amount(self):
        total_amount = 0
        count = 0
        for loan_list in self.loans.values():
            for _, _, amount, _ in loan_list:
                total_amount += amount
                count += 1
        if count == 0:
            return 0.0
        [span_76](start_span)return round(total_amount / count, 2)[span_76](end_span)

    def customers_with_multiple_loans(self):
        # [span_77](start_span)Returns names of individuals with more than 1 loan record[span_77](end_span)
        return [cust for cust, items in self.loans.items() if len(items) > 1]
```