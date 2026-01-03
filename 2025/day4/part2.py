import sys

def neighboring_coords(x, y, arr):
    surrounding_coords = [
        [x - 1, y - 1], [x, y - 1], [x + 1, y - 1], [x - 1, y], [x + 1, y], [x - 1, y + 1], [x, y + 1], [x + 1, y + 1],
    ]

    legit_coords = [coord for coord in surrounding_coords if
                    0 <= coord[0] and coord[0] <= len(arr[0]) - 1 and 0 <= coord[1] and coord[1] <= len(arr) - 1]
    return legit_coords

def count(x, y, arr):
    cnt = 0
    for coord in neighboring_coords(x, y, arr):
        if arr[coord[0]][coord[1]] == "@":
            cnt += 1

    return cnt

def reduce_neightbors(coords, arr_num):
    for neighboring_coord in neighboring_coords(coords[0], coords[1], arr):
        if arr_num[neighboring_coord[0]][neighboring_coord[1]] != None:
            arr_num[neighboring_coord[0]][neighboring_coord[1]] -= 1

def process(arr_num):
    coords_with_accessible_roll = []
    for x in range(len(arr_num[0])):
        for y in range(len(arr_num)):
            if arr_num[x][y] != None and arr_num[x][y] < 4:
                arr_num[x][y] = None
                coords_with_accessible_roll.append([x, y])

    for coords in coords_with_accessible_roll:
        reduce_neightbors(coords, arr_num)

    return len(coords_with_accessible_roll)

arr = []
for line in open(0):
    arr.append(list(line.strip()))

arr_num = [[count(x, y, arr) if arr[x][y] == "@" else None for y in range(len(arr[0]))] for x in range(len(arr))]

num = 0
while(True):
    rolls = process(arr_num)
    if rolls == 0:
        break;
    else:
        num += rolls

print(num)
