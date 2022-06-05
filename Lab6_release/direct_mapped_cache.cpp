#include "direct_mapped_cache.h"
#include "string"
#include <fstream>
#include <vector>
#include <sstream>
#include <bitset>
#include <cmath>

using namespace std;

vector<vector <int>> hextobinary(vector <string> buffer){
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

int binarytodecimal(vector <int> a, int start, int end){
    int answer = 0;
    for(int i = start; i <= end; i++){
        answer = answer * 2 + a[i];
    }
    return answer;
}

float direct_mapped(string filename, int block_size, int cache_size)
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
    
    vector<vector <int>>data = hextobinary(buffer);
    total_num = data.size();
    int block_num = (cache_size/block_size);
    int offset_length = int(log2(block_size));
    int index_length = int(log2(block_num));
    // int tag_length = 20;

    vector <int> cache(block_num);
    
    for(int i = 0; i < data.size(); i++){
        int index = binarytodecimal(data[i], 31-offset_length-index_length+1, 31-offset_length); //20 10 2 31-2 = 29 20 = 31 - 2 - 10
        int tag = binarytodecimal(data[i], 0, 32-offset_length-index_length-1); //19~10

        if(cache[index] == tag){
            hit_num++;
        }
        else{
            cache[index] = tag;
        }
    }
    return (float)hit_num/total_num;
}
