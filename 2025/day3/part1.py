import sys

total = 0

for line in open(0):
    bank = list(map(int, line.strip()))
    tens = max(bank[:-1])
    bank = bank[bank.index(tens) + 1:]
    ones = max(bank)
    total += tens * 10 + ones

print(total)