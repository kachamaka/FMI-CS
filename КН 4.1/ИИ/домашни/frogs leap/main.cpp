#include <iostream>
#include <cstring>
#include <algorithm> 
#include <stack>
#include <vector>

using namespace std;

struct State {
    string config;
    State* parent;

    State(string cfg, State* prnt = nullptr): config(cfg), parent(prnt) {

    }

    bool operator==(State& other) {
        return config == other.config;
    }

    ~State() {
        if (parent != nullptr) {
            delete parent;
            parent = nullptr;
        }
    }

    void print() {
        cout << config << "\n";
    }
    
};

void append(string& str, char c, int times) {
    int i = 0;
    while(i++ < times) {
        str.push_back(c);
    }
}

State* init(int n) {
    if(n < 1) {
        throw invalid_argument("n should be at least 1");
    }

    string str;
    append(str, '>', n);
    append(str, '_', 1);
    append(str, '<', n);
    State* s = new State(str);
    return s;
}

vector<State*> possibleMoves(State* state) {
    vector<State*> posMoves;
    string cfg = state->config;
    for(int i = 0; i < cfg.size(); ++i) {
        if (cfg[i] == '_') continue;
        if (cfg[i] == '>') {
            if (i + 1 < cfg.size() && cfg[i+1] == '_') {
                State* s = new State(cfg, state);
                swap(s->config[i], s->config[i+1]);
                posMoves.push_back(s);
            }
            if (i + 2 < cfg.size() && cfg[i+1] != '_' && cfg[i+2] == '_') {
                State* s = new State(cfg, state);
                swap(s->config[i], s->config[i+2]);
                posMoves.push_back(s);
            }
        }
        if (cfg[i] == '<') {
            if (i - 1 >= 0 && cfg[i-1] == '_') {
                State* s = new State(cfg, state);
                swap(s->config[i], s->config[i-1]);
                posMoves.push_back(s);
            }
            if (i - 2 >= 0 && cfg[i-1] != '_' && cfg[i-2] == '_') {
                State* s = new State(cfg, state);
                swap(s->config[i], s->config[i-2]);
                posMoves.push_back(s);
            }
        }
    }
    
    return posMoves;
} 

void dfs(State* initialState, State* finalState) {
    stack<State*> s;
    s.push(initialState);

    vector<string> res;

    bool found = false;
    State* state;

    while(!s.empty()) {
        state = s.top();
        s.pop();

        if (*state == *finalState) {
            found = true;
            break;
        }

        vector<State*> moves = possibleMoves(state);
        for(int i = 0; i < moves.size(); ++i) {
            s.push(moves[i]);
        }
    }

    if (found) {
        while(state != nullptr) {
            res.push_back(state->config);
            state = state->parent;
        }

        for(int i = res.size() - 1; i >= 0; --i) {
            cout << res[i] << "\n";
        }
    }

}

int main() {
    try {
        int n;
        cout << "N = ";
        cin >> n;
        
        State* initialState = init(n);
        State* finalState = new State(*initialState);
        reverse(finalState->config.begin(), finalState->config.end());

        dfs(initialState, finalState);
    }
    catch(const exception& e) {
        cerr << e.what() << '\n';
    }
}