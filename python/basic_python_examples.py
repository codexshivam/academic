"""
Basic Python Code Examples - Core Concepts and Operations
"""

# 1. Variables and Data Types
print("=== Variables and Data Types ===")

# Numbers
integer_num = 42
float_num = 3.14
complex_num = 3 + 4j

print(f"Integer: {integer_num}, Type: {type(integer_num)}")
print(f"Float: {float_num}, Type: {type(float_num)}")
print(f"Complex: {complex_num}, Type: {type(complex_num)}")

# Strings
string_var = "Hello, World!"
multiline_string = """This is a
multiline string"""

print(f"String: {string_var}")
print(f"Multiline: {multiline_string}")

# Boolean
is_true = True
is_false = False
print(f"Boolean: {is_true}, Type: {type(is_true)}")

# 2. Lists
print("\n=== Lists ===")

# Creating lists
numbers = [1, 2, 3, 4, 5]
mixed_list = [1, "hello", 3.14, True]
nested_list = [[1, 2], [3, 4], [5, 6]]

print(f"Numbers: {numbers}")
print(f"Mixed: {mixed_list}")
print(f"Nested: {nested_list}")

# List operations
numbers.append(6)
print(f"After append: {numbers}")

numbers.insert(0, 0)
print(f"After insert: {numbers}")

removed = numbers.pop()
print(f"Removed: {removed}, List: {numbers}")

# List comprehensions
squares = [x**2 for x in range(1, 6)]
even_squares = [x**2 for x in range(1, 11) if x % 2 == 0]

print(f"Squares: {squares}")
print(f"Even squares: {even_squares}")

# 3. Tuples
print("\n=== Tuples ===")

# Creating tuples
coordinates = (3, 4)
person_info = ("Alice", 25, "Engineer")
single_element = (42,)  # Note the comma

print(f"Coordinates: {coordinates}")
print(f"Person info: {person_info}")
print(f"Single element: {single_element}")

# Tuple unpacking
name, age, job = person_info
print(f"Unpacked - Name: {name}, Age: {age}, Job: {job}")

# 4. Dictionaries
print("\n=== Dictionaries ===")

# Creating dictionaries
person = {
    "name": "Alice",
    "age": 25,
    "city": "New York",
    "skills": ["Python", "JavaScript", "SQL"]
}

# Accessing values
print(f"Name: {person['name']}")
print(f"Age: {person.get('age', 'Unknown')}")
print(f"Skills: {person['skills']}")

# Dictionary operations
person["email"] = "alice@email.com"
person["age"] = 26

print(f"Updated person: {person}")

# Dictionary comprehensions
square_dict = {x: x**2 for x in range(1, 6)}
print(f"Square dictionary: {square_dict}")

# 5. Sets
print("\n=== Sets ===")

# Creating sets
fruits = {"apple", "banana", "orange"}
numbers_set = set([1, 2, 3, 4, 5])

print(f"Fruits: {fruits}")
print(f"Numbers: {numbers_set}")

# Set operations
fruits.add("grape")
fruits.remove("banana")

print(f"Updated fruits: {fruits}")

# Set operations
set1 = {1, 2, 3, 4}
set2 = {3, 4, 5, 6}

union = set1 | set2
intersection = set1 & set2
difference = set1 - set2

print(f"Set 1: {set1}")
print(f"Set 2: {set2}")
print(f"Union: {union}")
print(f"Intersection: {intersection}")
print(f"Difference: {difference}")

# 6. Control Flow
print("\n=== Control Flow ===")

# If-elif-else
score = 85

if score >= 90:
    grade = "A"
elif score >= 80:
    grade = "B"
elif score >= 70:
    grade = "C"
else:
    grade = "F"

print(f"Score: {score}, Grade: {grade}")

# For loops
print("\nFor loop examples:")
for i in range(5):
    print(f"Count: {i}")

for fruit in fruits:
    print(f"Fruit: {fruit}")

# While loops
count = 0
print("\nWhile loop:")
while count < 3:
    print(f"While count: {count}")
    count += 1

# 7. Functions
print("\n=== Functions ===")

# Basic function
def greet(name):
    return f"Hello, {name}!"

print(greet("Alice"))

# Function with default parameters
def power(base, exponent=2):
    return base ** exponent

print(f"5 squared: {power(5)}")
print(f"2 cubed: {power(2, 3)}")

# Function with multiple return values
def get_name_and_age():
    return "Bob", 30

name, age = get_name_and_age()
print(f"Name: {name}, Age: {age}")

# Lambda functions
square = lambda x: x ** 2
print(f"Lambda square of 4: {square(4)}")

# 8. Classes and Objects
print("\n=== Classes and Objects ===")

class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def greet(self):
        return f"Hi, I'm {self.name} and I'm {self.age} years old."
    
    def have_birthday(self):
        self.age += 1

# Creating objects
person1 = Person("Charlie", 35)
person2 = Person("Diana", 28)

print(person1.greet())
print(person2.greet())

person1.have_birthday()
print(f"After birthday: {person1.greet()}")

# 9. Exception Handling
print("\n=== Exception Handling ===")

# Basic try-except
try:
    result = 10 / 0
except ZeroDivisionError:
    print("Cannot divide by zero!")

# Multiple exceptions
try:
    value = int("not_a_number")
    result = 10 / value
except ValueError:
    print("Invalid number format!")
except ZeroDivisionError:
    print("Cannot divide by zero!")
except Exception as e:
    print(f"An error occurred: {e}")

# Try-except-else-finally
def safe_divide(a, b):
    try:
        result = a / b
    except ZeroDivisionError:
        print("Division by zero!")
        return None
    except TypeError:
        print("Invalid input types!")
        return None
    else:
        print("Division successful!")
        return result
    finally:
        print("Division operation completed.")

print(f"Result: {safe_divide(10, 2)}")
print(f"Result: {safe_divide(10, 0)}")

# 10. File Operations
print("\n=== File Operations ===")

# Writing to file
file_content = "Hello, World!\nThis is a test file.\nPython is awesome!"

with open("test_file.txt", "w") as file:
    file.write(file_content)

print("File written successfully!")

# Reading from file
with open("test_file.txt", "r") as file:
    content = file.read()

print(f"File content:\n{content}")

# Reading line by line
with open("test_file.txt", "r") as file:
    lines = file.readlines()

print("Lines:")
for i, line in enumerate(lines, 1):
    print(f"Line {i}: {line.strip()}")

# 11. String Operations
print("\n=== String Operations ===")

text = "  Hello, World!  "

# Basic string methods
print(f"Original: '{text}'")
print(f"Strip: '{text.strip()}'")
print(f"Lower: '{text.lower()}'")
print(f"Upper: '{text.upper()}'")
print(f"Replace: '{text.replace('World', 'Python')}'")

# String formatting
name = "Alice"
age = 25

# Old style
formatted1 = "Hello, %s! You are %d years old." % (name, age)
print(f"Old style: {formatted1}")

# .format method
formatted2 = "Hello, {}! You are {} years old.".format(name, age)
print(f".format(): {formatted2}")

# f-strings (Python 3.6+)
formatted3 = f"Hello, {name}! You are {age} years old."
print(f"f-string: {formatted3}")

# 12. List and Dictionary Comprehensions
print("\n=== Comprehensions ===")

# List comprehension
numbers = [1, 2, 3, 4, 5]
squared = [x**2 for x in numbers]
even_squared = [x**2 for x in numbers if x % 2 == 0]

print(f"Numbers: {numbers}")
print(f"Squared: {squared}")
print(f"Even squared: {even_squared}")

# Dictionary comprehension
square_dict = {x: x**2 for x in range(1, 6)}
even_square_dict = {x: x**2 for x in range(1, 11) if x % 2 == 0}

print(f"Square dict: {square_dict}")
print(f"Even square dict: {even_square_dict}")

# Set comprehension
unique_lengths = {len(word) for word in ["hello", "world", "python", "code"]}
print(f"Unique lengths: {unique_lengths}")

# 13. Generators
print("\n=== Generators ===")

# Generator function
def fibonacci(n):
    a, b = 0, 1
    count = 0
    while count < n:
        yield a
        a, b = b, a + b
        count += 1

# Using generator
fib_gen = fibonacci(10)
fib_numbers = list(fib_gen)
print(f"Fibonacci: {fib_numbers}")

# Generator expression
squares_gen = (x**2 for x in range(1, 6))
print(f"Generator squares: {list(squares_gen)}")

# 14. Modules and Imports
print("\n=== Modules and Imports ===")

# Using built-in modules
import math
import random
from datetime import datetime

print(f"Square root of 16: {math.sqrt(16)}")
print(f"Random number: {random.randint(1, 10)}")
print(f"Current time: {datetime.now()}")

# 15. Decorators
print("\n=== Decorators ===")

def timing_decorator(func):
    import time
    def wrapper(*args, **kwargs):
        start_time = time.time()
        result = func(*args, **kwargs)
        end_time = time.time()
        print(f"Function {func.__name__} took {end_time - start_time:.4f} seconds")
        return result
    return wrapper

@timing_decorator
def slow_function():
    time.sleep(0.1)  # Simulate slow operation
    return "Done!"

result = slow_function()
print(f"Result: {result}")

# 16. Context Managers
print("\n=== Context Managers ===")

class SimpleContextManager:
    def __enter__(self):
        print("Entering context")
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        print("Exiting context")
        return False

# Using context manager
with SimpleContextManager() as cm:
    print("Inside context")

# 17. Regular Expressions
print("\n=== Regular Expressions ===")

import re

text = "Contact us at support@company.com or call 123-456-7890"

# Find email
email_pattern = r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}\b'
emails = re.findall(email_pattern, text)
print(f"Found emails: {emails}")

# Find phone numbers
phone_pattern = r'\b\d{3}-\d{3}-\d{4}\b'
phones = re.findall(phone_pattern, text)
print(f"Found phones: {phones}")

# 18. JSON Operations
print("\n=== JSON Operations ===")

import json

# Python object to JSON
data = {
    "name": "Alice",
    "age": 25,
    "skills": ["Python", "JavaScript"],
    "is_student": True
}

json_string = json.dumps(data, indent=2)
print("JSON string:")
print(json_string)

# JSON to Python object
parsed_data = json.loads(json_string)
print(f"Parsed data: {parsed_data}")
print(f"Name: {parsed_data['name']}")

# Clean up test file
import os
if os.path.exists("test_file.txt"):
    os.remove("test_file.txt")
    print("\nTest file cleaned up.")
