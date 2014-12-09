#include <iostream>
using namespace std;

class ass_test
{
    private:
        double m_per;
        int m_ne;
        static int cou;
    public:
        ass_test operator=(ass_test & tmp)
        {
            cout<<"assign a new object"<<endl;
            this->m_per = tmp.m_per;
            this->m_ne = tmp.m_ne;
            return *this;
        }
        ass_test()
        {
            cou++;
            cout<<"constructor a new object "<<cou<<endl;
            m_per = 3.14;
            m_ne = 3;
        }
        ass_test(double p, int n)
        {
            cou++;
            cout<<"constructor a new object "<<cou<<endl;
            m_per = p;
            m_ne = n;
        }
        void get()
        {
            cout<<"per: "<<m_per<<" address:"<<&m_per<<endl;
            cout<<"ne: "<<m_ne<<" address:"<<&m_ne<<endl;
            cout<<"counter: "<<cou<<" address:"<<&cou<<endl;
        }
};
int ass_test::cou = 0;
int main()
{
    ass_test tmp1(4.555555, 100000000);
    cout<<"address: "<<&tmp1<<endl;
    ass_test tmp2;
    tmp2 = tmp1;
    tmp2.get();
    cout<<"address: "<<&tmp2<<endl;
    ass_test tmp3 = tmp2;
    tmp3.get();
    cout<<"address: "<<&tmp3<<endl;
}
