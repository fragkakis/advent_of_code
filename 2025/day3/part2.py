import sys

total = 0

for line in open(0):
    print(f"line {line}")
    bank = list(map(int, line.strip()))
    jolts = ""
    for index in range(11):
        digit = max(bank[:index-11])
        bank = bank[bank.index(digit) + 1:]
        jolts += str(digit)
    jolts += str(max(bank))
    total += int(jolts)

print(f"total {total}")