// C++ program to find size
// of an array by using a
// pointer hack
#include <iostream>
using namespace std;
 
int main()
{
    int arr[] = { 1, 2, 3, 4, 5, 6 };
    std::string arr2[] = { "hello","world"};
    int size = *(&arr + 1) - arr;
    int size2 = *(&arr2 + 1) - arr2;
    cout << "Number of elements in arr[] is " << size;
    cout << "Number of elements in arr[] is " << size2;
    return 0;
}   
