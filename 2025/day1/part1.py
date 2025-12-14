instructions = [line.strip() for line in open(0)]
pointer = 50
zero_count = 0

for instruction in instructions:
    direction = instruction[0]
    steps = int(instruction[1:]) if direction == "R" else -int(instruction[1:])
    pointer = (pointer + steps) % 100

    if pointer == 0:
        zero_count += 1

print("zeros so far", zero_count)
