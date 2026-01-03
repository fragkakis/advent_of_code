import sys

def count(x, y, arr):
    surrounding_coords = [
        [x-1, y-1], [x, y-1], [x+1, y-1], [x - 1, y], [x + 1, y], [x - 1, y + 1], [x, y + 1], [x + 1, y + 1],
    ]

    legit_coords = [coord for coord in surrounding_coords if 0 <= coord[0] and coord[0] <= len(arr[0]) - 1 and 0 <= coord[1] and coord[1] <= len(arr) - 1]

    cnt = 0
    for coord in legit_coords:
        if arr[coord[0]][coord[1]] == "@":
            cnt += 1

    return cnt

arr = []
for line in open(0):
    arr.append(list(line.strip()))

num = 0
for x in range(len(arr[0])):
    for y in range(len(arr)):
        if arr[x][y] == '@' and count(x, y, arr) < 4:
            num += 1
print(num)

