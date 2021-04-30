x = [10,8,15,1,99,0]
def BetterSort(list):
    n = len(list)
    for i in range(1,n):
        for j in range(i,0,-1):
            if list[j] < list[j-1]:
                list[j-1],list[j] = list[j],list[j-1]
            else:
                break
    return list
BetterSort(x)
y = [1,6,45,88,4,32,2]
BetterSort(y)
