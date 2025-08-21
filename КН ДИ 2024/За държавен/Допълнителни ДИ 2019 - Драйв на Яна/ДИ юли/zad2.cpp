#include <bits/stdc++.h>

struct Node
{
    char symbol;
    int value;
    std::vector<Node*> children;
    Node(const char& sym, const int& val) : symbol(sym), value(val){};
};

void dfs(Node* a, Node* b, int& result, int& currentPath)
{
    if (!a && !b)
    {
        result += currentPath;
        currentPath = 0;
    }
    else if (a->children.empty() && b->children.empty())
    {
        printf("a: %c %d, b: %c %d current: %d\n", a->symbol, a->value,
               b->symbol, b->value, currentPath);

        if (a->symbol == b->symbol)
        {
            result += currentPath + a->value + b->value;
        }
        currentPath = 0;
    }
    else if (a && b)
    {
        printf("a: %c %d, b: %c %d current: %d\n", a->symbol, a->value,
               b->symbol, b->value, currentPath);
               
        if (a->symbol == b->symbol)
        {
            currentPath += a->value + b->value;
            for (auto&& aNode : a->children)
            {
                for (auto&& bNode : b->children)
                {
                    dfs(aNode, bNode, result, currentPath);
                }
            }
            currentPath -= a->value + b->value;
        }
        else
        {
            currentPath = 0;
        }
    }
    else
    {
        currentPath = 0;
    }
}

int sumVal(Node* a, Node* b)
{
    int result = 0, currentPath = 0;
    dfs(a, b, result, currentPath);
    return result;
}

int main()
{
    Node* root = new Node('a', -1);
    Node* root1 = new Node('b', -50);
    Node* root2 = new Node('c', 10);
    Node* root3 = new Node('s', 19);
    Node* root4 = new Node('g', 9);
    Node* root5 = new Node('a', 12);
    Node* root6 = new Node('c', 6);
    Node* root7 = new Node('g', 5);
    Node* root8 = new Node('a', -92);
    Node* root9 = new Node('a', 1);
    Node* root10 = new Node('b', 0);
    Node* root11 = new Node('a', 9);
    Node* root12 = new Node('c', 10);

    root->children.push_back(root5);
    root5->children.push_back(root2);
    root2->children.push_back(root11);

    root->children.push_back(root9);
    root9->children.push_back(root12);
    root12->children.push_back(root4);
    printf("%d\n", sumVal(root5, root9));
}