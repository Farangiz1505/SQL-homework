import random
import string
import datetime

# 1. Age Calculator
name = input("Enter your name: ")
birth_year = int(input("Enter your year of birth: "))
current_year = datetime.datetime.now().year
age = current_year - birth_year
print(f"{name}, you are {age} years old.")

# 2. Extract Car Names from 'LMaasleitbtui'
txt1 = 'LMaasleitbtui'
car1 = txt1[1::2]  # every second character starting from index 1
print("Extracted car name 1:", car1)

# 3. Extract Car Names from 'MsaatmiazD'
txt2 = 'MsaatmiazD'
car2 = txt2[::2]  # every second character starting from index 0
print("Extracted car name 2:", car2)

# 4. Extract Residence Area
txt3 = "I'am John. I am from London"
area = txt3.split("from ")[1]
print("Residence area:", area)

# 5. Reverse String
user_string = input("Enter a string to reverse: ")
print("Reversed string:", user_string[::-1])

# 6. Count Vowels
text = input("Enter a string to count vowels: ").lower()
vowels = "aeiou"
vowel_count = sum(1 for char in text if char in vowels)
print("Number of vowels:", vowel_count)

# 7. Find Maximum Value
numbers = list(map(int, input("Enter numbers separated by space: ").split()))
max_value = max(numbers)
print("Maximum value:", max_value)

# 8. Check Palindrome
word = input("Enter a word to check palindrome: ")
is_palindrome = word == word[::-1]
print("Is palindrome:", is_palindrome)

# 9. Extract Email Domain
email = input("Enter your email: ")
domain = email.split('@')[-1]
print("Email domain:", domain)

# 10. Generate Random Password
password_length = 12
characters = string.ascii_letters + string.digits + string.punctuation
password = ''.join(random.choice(characters) for _ in range(password_length))
print("Random password:", password)
