#Question 1: Student Marks Manager (Dictionary)

Problem Statement

Create a class StudentMarksManager to manage student marks using a dictionary.

Implement the following functions:

1. __init__() → Initialize an empty dictionary.


2. add_student(name, marks) → Add a student's marks.


3. find_highest_marks() → Return the highest marks.


4. total_marks() → Return the sum of all marks.


5. update_marks(name, new_marks) → Update marks of a student.


6. get_marks(name) → Return marks of a given student.




```python

Solution

class StudentMarksManager:

    def __init__(self):
        self.students = {}

    def add_student(self, name, marks):
        self.students[name] = marks

    def find_highest_marks(self):
        if len(self.students) == 0:
            return None
        return max(self.students.values())

    def total_marks(self):
        return sum(self.students.values())

    def update_marks(self, name, new_marks):
        if name in self.students:
            self.students[name] = new_marks

    def get_marks(self, name):
        return self.students.get(name, "Student not found")


# Driver code
obj = StudentMarksManager()

obj.add_student("Rahul", 85)
obj.add_student("Priya", 92)
obj.add_student("Aman", 78)

print("Highest Marks:", obj.find_highest_marks())
print("Total Marks:", obj.total_marks())

obj.update_marks("Rahul", 95)

print("Rahul Marks:", obj.get_marks("Rahul"))


```

#Question 2: Shopping Cart Manager (List)

Problem Statement

Create a class ShoppingCart to store item prices in a list.

Implement these functions:

1. __init__() → Initialize an empty list.


2. add_item(price) → Add item price.


3. find_max_price() → Return maximum price.


4. total_bill() → Return total amount.


5. remove_item(price) → Remove an item from the list.


6. show_items() → Return all items.




```python

Solution

class ShoppingCart:

    def __init__(self):
        self.items = []

    def add_item(self, price):
        self.items.append(price)

    def find_max_price(self):
        if len(self.items) == 0:
            return None
        return max(self.items)

    def total_bill(self):
        return sum(self.items)

    def remove_item(self, price):
        if price in self.items:
            self.items.remove(price)

    def show_items(self):
        return self.items


# Driver code
cart = ShoppingCart()

cart.add_item(200)
cart.add_item(500)
cart.add_item(150)

print("Items:", cart.show_items())
print("Maximum Price:", cart.find_max_price())
print("Total Bill:", cart.total_bill())

cart.remove_item(150)

print("Items after removal:", cart.show_items())


```

#Question 3: Employee Attendance System (Dictionary + List)

Problem Statement

Create a class EmployeeAttendanceSystem that stores attendance status of employees.

Each employee can have multiple attendance entries like "Present", "Absent", etc.

Implement these functions:

1. __init__() → Initialize an empty dictionary.


2. add_attendance(employee, status) → Add attendance status.


3. count_present(employee) → Count how many times employee was present.


4. total_entries(employee) → Return total attendance records.


5. update_last_status(employee, status) → Change the latest status.


6. get_attendance(employee) → Return attendance list.




```python

Solution

class EmployeeAttendanceSystem:

    def __init__(self):
        self.attendance = {}

    def add_attendance(self, employee, status):
        if employee not in self.attendance:
            self.attendance[employee] = []
        self.attendance[employee].append(status)

    def count_present(self, employee):
        if employee in self.attendance:
            return self.attendance[employee].count("Present")
        return 0

    def total_entries(self, employee):
        if employee in self.attendance:
            return len(self.attendance[employee])
        return 0

    def update_last_status(self, employee, status):
        if employee in self.attendance and len(self.attendance[employee]) > 0:
            self.attendance[employee][-1] = status

    def get_attendance(self, employee):
        return self.attendance.get(employee, [])


# Driver code
system = EmployeeAttendanceSystem()

system.add_attendance("Rohan", "Present")
system.add_attendance("Rohan", "Absent")
system.add_attendance("Rohan", "Present")

print("Attendance:", system.get_attendance("Rohan"))
print("Present Count:", system.count_present("Rohan"))
print("Total Entries:", system.total_entries("Rohan"))

system.update_last_status("Rohan", "Absent")

print("Updated Attendance:", system.get_attendance("Rohan"))


```

Pattern to Remember for Beginner OOP Questions

Most easy IAMNeo/Examly questions follow this structure:

1. __init__()            -> Initialize list/dictionary
2. add_xxx()             -> Insert data
3. find_max()/count()    -> Maximum or frequency
4. total_xxx()/sum()     -> Sum or length
5. update_xxx()/remove() -> Modify data
6. get_xxx()/show_xxx()  -> Return data

If you can solve this pattern with lists and dictionaries, you'll be able to solve most beginner-level OOP questions on Examly/IAMNeo platforms.