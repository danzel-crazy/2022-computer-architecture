#include "set_associative_cache.h"
#include "string"
#include <fstream>
#include <vector>
#include <sstream>
#include <bitset>
#include <cmath>

using namespace std;

vector<vector <int>> hextobin(vector <string> buffer){
    vector<vector <int>> answer;
    answer.resize(buffer.size());
    for(int i = 0; i < buffer.size(); i++){
        stringstream ss;
        ss << hex << buffer[i];
        unsigned n;
        ss >> n;
        bitset <32> b(n);
        string t = b.to_string();
        // cout << buffer[i] << endl;
        // cout << t << endl;
        for(auto j : t){
            answer[i].push_back(j-'0');
        }
    }
    return answer;
}

int bintodec(vector <int> a, int start, int end){
    int answer = 0;
    for(int i = start; i <= end; i++){
        answer = answer * 2 + a[i];
    }
    return answer;
}

float set_associative(string filename, int way, int block_size, int cache_size)
{
    int total_num = -1;
    int hit_num = 0;

    /*write your code HERE*/
    string line;
    fstream file;
    vector <string> buffer;
    file.open(filename, ios::in);
    while(getline(file, line)){
        buffer.push_back(line);
        // cout << line << endl;
    }
    file.close();
    
    vector<vector <int>>data = hextobin(buffer);
    total_num = data.size();
    int block_num = (cache_size/block_size)/way;
    int offset_length = int(log2(block_size));
    int index_length = int(log2(block_num));

    vector <vector <int>> cache(way);
    vector <vector <int>> lru(way);
    for(int i = 0; i < way; i++){
        cache[i].resize(block_num,0);
        lru[i].resize(block_num,0);
    }

    int current_num = 0;
    bool hit = false;
    for(int i = 0; i < data.size(); i++){
        hit = false;
        int index = bintodec(data[i], 31-offset_length-index_length+1, 31-offset_length); //20 10 2 31-2 = 29 20 = 31 - 2 - 10
        int tag = bintodec(data[i], 0, 32-offset_length-index_length-1); //19~10

        
        for(int i = 0; i < way; i++){
            if(cache[i][index] == tag){
                lru[i][index] = current_num;
                hit_num++;
                hit = true;
                break;
            }
        }

        if(!hit){
            int last_use = 0; int last_num = -1;
            for(int i = 0; i < way; i++){
                if(lru[i][index] < last_num || last_num == -1){
                    last_use = i;
                    last_num = lru[i][index];
                }
            }
            cache[last_use][index] = tag;
            lru[last_use][index] = current_num;
        }
        current_num++;
    }
    return (float)hit_num/total_num;
}
