#### constructor

A constructor is a special kind of class member function that is executed when an object of that class is instantiated.<br>
Constructors are typically used to initialize member variables of the class to appropriate default values, or to allow the user to easily initialize those member variables to whatever values are desired.

Unlike normal functions, constructors have specific rules for how they must be named:
1) Constructors should always have the same name as the class (with the same capitalization)
2) Constructors have no return type (not even void)

A constructor that takes no parameters (or has all optional parameters)is called a default constructor.

##### Constructors with parameters

While the default constructor is great for ensuring our classes are initialized with reasonable default values, often times we want instances of our class to have specific values. Fortunately, constructors can also be declared with parameters. Here is an example of a constructor that takes two integer parameters that are used to initialize the numerator and denominator:

```cpp
#include <cassert>
class Fraction
{
private:
    int m_nNumerator;
    int m_nDenominator;
         
public:
    Fraction() //default constructor
    {
        m_nNumerator = 0;
        m_nDenominator = 1;
    }
    // Constructor with parameters
    Fraction(int nNumerator, int nDenominator=1)
    {
        assert(nDenominator != 0);
        m_nNumerator = nNumerator;
        m_nDenominator = nDenominator;
    }

    int GetNumerator(){return m_nNumerator;}
    int GetDenominator(){return m_nDenominator;}
    double GetFraction(){return static_cast<double>(m_nNumerator) / m_nDenminator;}
};
```

Note that we now have two constructors: a default constructor that will be called in the default case, and a second constructor that takes two parameters.<br>
These two constructors can coexist peacefully in the same class due to function overloading. In fact, you can define as many constructors as you want, so long as each has a unique signature(number and type of parameters).

So how do we use this constructor with parameters? It’s simple:

```cpp
Fraction cFiveThirds(5, 3); //calls Fraction(int, int) constructor
```

This particular fraction will be initialized to the fraction 5/3!

Note that we have made use of a default value for the second parameter of the constructor with parameters, so the following is also legal:

```cpp
Fraction Six(6); //calls Fraction(int, int) constructor
```

In this case, our default constructor is actually somewhat redundant. We could simplify this class as follows:

```cpp
#include <cassert>
class Fraction
{
private:
    int m_nNumerator;
    int m_nDenominator;
         
public:
    // Default constructor
    Fraction(int nNumerator=0, int nDenominator=1)
    {
        assert(nDenominator != 0);
        m_nNumerator = nNumerator;
        m_nDenominator = nDenominator;
    }

    //the same member functions
};
```

This constructor has been defined in a way that allows it to serve as both a default and a non-default constructor!

##### Classes without default constructors

What happens if we do not declare a default constructor and then instantiate our class? 

The answer is that C++ will allocate space for our class instance, but will not initialize the members of the class (similar to what happens when you declare an int, double, or other basic data type).

#### Destructor

A destructor is another special kind of class member function that is executed when an object of that class is destroyed.<br> 
They are the counterpart to constructors. When a variable goes out of scope, or a dynamically allocated variable is explicitly deleted using the delete keyword, the class destructor is called (if it exists) to help clean up the class before it is removed from memory.<br> 
For simple classes, a destructor is not needed because C++ will automatically clean up the memory for you. However, if you have dynamically allocated memory, or if you need to do some kind of maintenance before the class is destroyed (eg. closing a file), the destructor is the perfect place to do so.

Like constructors, destructors have specific naming rules:
1) The destructor must have the same name as the class, preceded by a tilde (~).
2) The destructor can not take arguments.
3) The destructor has no return type.

Note that rule 2 implies that only one destructor may exist per class, as there is no way to overload destructors since they can not be differentiated from each other based on arguments.

Constructor and destructor timing

As mentioned previously, the constructor is called when an object is created, and the destructor is called when an object is destroyed. In the following example, we use cout statements inside the constructor and destructor to show this:

```cpp
class Simple
{
private:
    int m_nID;

    public:
        Simple(int nID)
        {
            std::cout << "Constructing Simple " << nID<< std::endl;
            m_nID = nID;
        }

        ~Simple()
        {
            std::cout << "Destructing Simple" << m_nID << std::endl;
        }

        int GetID() { return m_nID; }
};

int main()
{
    // Allocate a Simple on the stack
    Simple cSimple(1);
    std::cout << cSimple.GetID() << std::endl;
    // Allocate a Simple dynamically
    Simple *pSimple = new Simple(2);
    std::cout << pSimple->GetID() << std::endl;
    delete pSimple;

    return 0;
} // cSimple goes out of scope here
```

This program produces the following result:

Constructing Simple 1<br>
1<br>
Constructing Simple 2<br>
2<br>
Destructing Simple 2<br>
Destructing Simple 1

