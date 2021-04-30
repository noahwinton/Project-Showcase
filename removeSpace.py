def removeSpace(str):
    output = str[0]
    n = len(str)
    for i in range(1,n):
        if (str[i] != ' '):
            output = output + str[i]
        elif (str[i] == ' ' and str[i-1] != ' '):
            output = output + str[i]
        elif (str[i] == ' ' and str[i-1] == ' '):
            continue
    return(output)
x = 'a  b  c'
removeSpace(x)
y = 'old macdonald   had a    farm'
removeSpace(y)
