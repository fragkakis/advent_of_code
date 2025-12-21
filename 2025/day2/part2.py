import sys
import textwrap
data = sys.stdin.read()
ranges = data.split(",")

sum = 0
for r in ranges:
    [min, max] = list(map(int, r.split("-")))
    for i in range(min, max+1):

        i_str = str(i)
        half_length = len(i_str) // 2
        for l in range(1, half_length+1):
            result = textwrap.wrap(i_str, width=l)
            if len(set(result)) == 1:
                sum += i
                break

print(sum)





