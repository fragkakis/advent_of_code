import sys
data = sys.stdin.read()
ranges = data.split(",")

sum = 0
for r in ranges:
    [min, max] = list(map(int, r.split("-")))
    for i in range(min, max+1):
        i_str = str(i)
        if len(i_str) % 2 != 0:
            continue
        half_length = len(i_str) // 2
        if(i_str[:half_length] == i_str[half_length:]):
            sum += i

print(sum)





