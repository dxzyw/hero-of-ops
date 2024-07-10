import numpy as np

#三角形网格的表面积
def cal_area(pos, conn):
    n = conn.shape[1]
    area = 0
    for i in range(n):
        pos0 = pos[:, conn[0, i]]
        pos1 = pos[:, conn[1, i]]
        pos2 = pos[:, conn[2, i]]
        v1 = pos1 - pos0
        v2 = pos2 - pos0
        area += np.linalg.norm(np.cross(v1, v2))
    return 0.5 * area
# 在一个二维数组gr中查找第一行（y值）最大值之后的最小值，并返回对应的第一列（x值）的值
def firstfloor_search(gr):
    totalnumber = gr.shape[1]
    number_of_ymax = np.argmax(gr[1, :])
    minimum = gr[1, number_of_ymax]
    order = number_of_ymax
    for i in range(number_of_ymax, totalnumber):
        if gr[1, i] < minimum:
            minimum = gr[1, i]
            order = i
    return gr[0, order]

if __name__ == '__main__':


    gr = np.array([[1, 2, 3, 4, 5], [5, 4, 3, 2, 1]])
    x_value = firstfloor_search(gr)

    print(x_value)
