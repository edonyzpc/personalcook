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
