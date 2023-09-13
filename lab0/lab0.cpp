#include<iostream>

//在此添加宏定义，并特意不加括号，探究宏展开的特性
#define test_string 1+2

using namespace std;
int main()
{
	int i, n ,f;
	cin >> n;
	i = 2;
	f = 1;

	while(i<=n)
	{
		f = f*i;
		i++;
	}
	cout<<f<<endl;
	
	cout<<test_string*3<<endl;
	return 0;	
}
