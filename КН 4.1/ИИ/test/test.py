# import time

# def manhattan_distance(state, N):
#     distance = 0
#     for num in state:
#         if num != 0:
#             current_row, current_col = divmod(state.index(num), N)
#             target_row, target_col = divmod(num - 1, N)
#             distance += abs(current_row - target_row) + abs(current_col - target_col)
#     return distance

# def is_solvable(state, N):
#     inv_count = 0
#     for i in range(N * N - 1):
#         for j in range(i + 1, N * N):
#             if state[i] != 0 and state[j] != 0 and state[i] > state[j]:
#                 inv_count += 1
#     return inv_count % 2 == 0

# def ida_star_search(state, N, blank_index, depth, bound, path, visited):
#     if state == list(range(1, N * N)) + [0]:
#         return True, path

#     distance = manhattan_distance(state, N)
#     total_cost = depth + distance
#     if total_cost > bound:
#         return False, total_cost
    
#     min_cost = float('inf')
#     for move in [(0, 1), (1, 0), (0, -1), (-1, 0)]:
#         new_blank_index = blank_index[0] + move[0], blank_index[1] + move[1]
#         if 0 <= new_blank_index[0] < N and 0 <= new_blank_index[1] < N:
#             new_state = state[:]
#             new_blank_pos = new_blank_index[0] * N + new_blank_index[1]
#             new_state[blank_index[0] * N + blank_index[1]], new_state[new_blank_pos] = new_state[new_blank_pos], new_state[blank_index[0] * N + blank_index[1]]
#             if tuple(new_state) not in visited:
#                 visited.add(tuple(new_state))
#                 found, new_path = ida_star_search(new_state, N, new_blank_index, depth + 1, bound, path + [move], visited)
#                 if found:
#                     return True, new_path
#                 if new_path[-1] != (-move[0], -move[1]):
#                     visited.remove(tuple(new_state))
#                 min_cost = min(min_cost, new_path[-1][0] + new_path[-1][1] - 1)
#     return False, min_cost

# def solve_puzzle(N, blank_index, initial_state):
#     if not is_solvable(initial_state, N):
#         return "Нерешима конфигурация на пъзел."
    
#     start_time = time.time()
#     bound = manhattan_distance(initial_state, N)
#     path = []
#     found = False
#     while not found:
#         visited = set()
#         visited.add(tuple(initial_state))
#         found, path = ida_star_search(initial_state, N, blank_index, 0, bound, [], visited)
#         bound = path[-1][0] + path[-1][1] - 1
#     end_time = time.time()
    
#     duration = round(end_time - start_time, 2)
#     return duration, len(path), path

# # Пример за използване:
# N = int(input("Въведете броя на плочките с номера: "))
# blank_index = input("Въведете индекса на празната плочка (формат: ред, колона): ").split(',')
# blank_index = (int(blank_index[0]), int(blank_index[1]))
# initial_state = input("Въведете началната конфигурация на пъзела (формат: ред по ред, цифри разделени с интервал): ").split()
# initial_state = [int(num) for num in initial_state]

# duration, steps, path = solve_puzzle(N, blank_index, initial_state)
# print("Дължина на оптималния път: ", steps)
# print("Стъпките, които трябва да бъдат извършени:")
# for step in path:
#     if step == (0, 1):
#         print("right")
#     elif step == (1, 0):
#         print("down")
#     elif step == (0, -1):
#         print("left")
#     elif step == (-1, 0):
#         print("up")
# print("Време за намиране на пътя: ", duration, "секунди")
