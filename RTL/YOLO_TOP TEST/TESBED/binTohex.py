with open('matrix_exp.dat', 'r') as file:
    data = file.read().splitlines()

# 转换为hex形式
hex_data = [hex(int(line, 2))[2:].zfill(16) for line in data]

# 将hex数据写回dat文件
with open('output.dat', 'w') as file:
    for line in hex_data:
        file.write(line + '\n')
