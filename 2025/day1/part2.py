instructions = [line.strip() for line in open(0)]
pointer = 50
zero_count = 0

for instruction in instructions:
    direction = instruction[0]
    steps = int(instruction[1:]) if direction == "R" else -int(instruction[1:])
    if steps < 0:
        div, mod = divmod(steps, -100)
        zero_count += div
        if pointer != 0 and pointer + mod <= 0:
            zero_count += 1
    else:
        div, mod = divmod(steps, 100)
        zero_count += div
        if pointer + mod >= 100:
            zero_count += 1

    pointer = (pointer + steps) % 100

print("zeros so far", zero_count)
