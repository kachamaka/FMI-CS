bool solution(const char* str)
{
    for (int i = 0; i < 6; ++i)
    {
        for (int j = 0; j < 6; ++j)
        {
            if (helper(i, j, str))
            {
                return true;
            }
        }
    }

    return false;
}

bool helper(int row, int col, const char* str)
{
    if (str == "\0")
    {
        return true;
    }

    if (row < 0 || col < 0 || row > 6 || col > 6)
    {
        return false;
    }

    if (lab[row][col] == *str)
    {
        str++;
    }
    
    lab[row][col] *= -1;

    bool result = helper(row + 1, col, str) || helper(row - 1, col, str) ||
                  helper(row, col + 1, str) || helper(row, col - 1, str);

    lab[row][col] *= -1;

    return result;
}