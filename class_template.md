#### class template
##### class template definition:<br>
```cpp
//declare
template <class T>//or <typename T>
class name
{
    public:
        void func();
        //details omitted...
    private:
        //details omitted...
};
//definition
template <class T>
void name::func()
{
    //some expressions omitted...
}
//...
```
------
##### class template instantiation:<br>
when instantiating a template, the compiler creates a new class with the given template argument. For example:<br>
```cpp
template<typename T>
struct Foo
{
    T bar;
    void doSomething(T param){/*do something*/}
};

// somewhere in a .cpp
Foo<int> f;
```

When reading this line, the compiler will create a new class (let's call it Foointa),which is equivalent to the following:<br>
```cpp
struct FooInt
{
    T bar;
    void doSomething(int param){/*do somethin*/}
}
```

Consequently, the compiler needs to have access to the implementation of the methods, to instantiate them with the template argument (in this case int).If these implementations were not in the header, they wouldn't be accessible, and therefore the compiler wouldn't be able to instantiate the template.

A common solution to this is to write the template declaration in a header file, then implement the class in an implementation file (for example .tpp), and include this implementation file at the end of the header.

```cpp
// Foo.h
template <typename T>
struct Foo
{
    void doSomething(T param);
};
#include "Foo.tpp"

// Foo.tpp
template <typename T>
void Foo<T>::doSomething(T param)
{
    //implementation
}
```

This way, implementation is still separated from declaration, but is accessible to the compiler.

Another solution is to keep the implementation separated, and explicitly instantiate all the template instances you'll need:

```cpp
// Foo.h

// no implementation
template <typename T> struct Foo {...};

//----------------------
//Foo.cpp

//implementation of Foo's methods

//explicit instantiation
template class Foo<int>;
template class Foo<float>;
// You will only be able to use Foo with int or float
```
Of course, there is another way to do explicit instantiation class template:

```cpp
// Foo.h

// no implementation
template <typename T> struct Foo {...};

//----------------------
//Foo.cpp

//implementation of Foo's methods

//----------------------
//Fooint.cpp
//add this file when you compile this class template
#include "Foo.cpp"
//explicit instantiation
template class Foo<int>;
template class Foo<float>;
```
###### reference:[Stackoverflow](http://stackoverflow.com/questions/495021/why-can-templates-only-be-implemented-in-the-header-file)

------------
#### Expression parameters and template specialization

you’ve learned how to use template type parameters to create functions and classes that are type independent. However, template type parameters are not the only type of template parameters available. <br>
Template classes (not template functions)can make use of another kind of template parameter known as an expression parameter.

##### Expression parameters

A template expression parameter is a parameter that does not substitute for a type, but is instead replaced by a value. An expression parameter can be any of the following:

* A value that has an integral type or enumeration
* A pointer or reference to an object
* A pointer or reference to a function
* A pointer or reference to a class member function

In the following example, we create a buffer class that uses both a type parameter and an expression parameter. <br>
The type parameter controls the data type of the buffer array, and the expression parameter controls how large the buffer array is.

```cpp
template <typename T, int nSize> // nSize is the expression parameter
class Buffer
{
private:
    // The expression parameter controls the size of the array
    T m_atBuffer[nSize];
 
public:
    T* GetBuffer() { return m_atBuffer; }
 
    T& operator[](int nIndex)
    {
        return m_atBuffer[nIndex];
    }
};
 
int main()
{
    // declare an integer buffer with room for 12 chars
    Buffer<int, 12> cIntBuffer;
 
    // Fill it up in order, then print it backwards
    for (int nCount=0; nCount < 12; nCount++)
        cIntBuffer[nCount] = nCount;
 
    for (int nCount=11; nCount >= 0; nCount--)
        std::cout << cIntBuffer[nCount] << " ";
    std::cout << std::endl;
 
    // declare a char buffer with room for 31 chars
    Buffer<char, 31> cCharBuffer;
 
    // strcpy a string into the buffer and print it
    strcpy(cCharBuffer.GetBuffer(), "Hello there!");
    std::cout << cCharBuffer.GetBuffer() << std::endl;
 
    return 0;
}
```

This code produces the following:

11 10 9 8 7 6 5 4 3 2 1 0
Hello there!

One noteworthy thing about the above example is that we do not have to dynamically allocate the m_atBuffer member array! This is because for any given instance of the Buffer class, nSize is actually constant. For example, if you instantiate a Buffer, the compiler replaces nSize with 12. Thus m_atBuffer is of type int[12], which can be allocated statically.

Template specialization

When instantiating a template class for a given type, the compiler stencils out a copy of each templated member function, and replaces the template type parameters with the actual types used in the variable declaration. This means a particular member function will have the same implementation details for each instanced type. While most of the time, this is exactly what you want, occasionally there are cases where it is useful to implement a templated member function slightly different for a specific data type. Template specialization lets you accomplish exactly this.

Let’s take a look at a very simple example:

```cpp
using namespace std;
 
template <typename T>
class Storage
{
private:
    T m_tValue;
public:
    Storage(T tValue)
    {
         m_tValue = tValue;
    }
 
    ~Storage()
    {
    }
 
    void Print()
    {
        std::cout << m_tValue << std::endl;;
    }
};
```

The above code will work fine for many data types:

```cpp
int main()
{
    // Define some storage units
    Storage<int> nValue(5);
    Storage<double> dValue(6.7);
 
    // Print out some values
    nValue.Print();
    dValue.Print();
}

```

This prints:
5
6.7

Now, let’s say we want double values to output in scientific notation. To do so, we will need to use template specialization to create a specialized version of the Print()function for doubles. <br>
This is extremely simple: simply define the specialized function outside of the class definition, replacing the template type with the specific type you wish to redefine the function for.<br>
Here is our specialized Print()function for doubles:

```cpp
void Storage<double>::Print()
{
    std::cout << std::scientific << m_tValue << std::endl;
}

```

When the compiler goes to instantiate Storage<double>::Print(), it will see we’ve already defined one, and it will use the one we’ve defined instead of stenciling out a version from the generic templated member function.

As a result, when we rerun the above program, it will print:
5
6.700000e+000

Now let’s take a look at another example where template specialization can be useful. Consider what happens if we try to use our templated Storage class with datatype char*:

```cpp
int main()
{
    using namespace std;
 
    // Dynamically allocate a temporary string
    char *strString = new char[40];
 
    // Ask user for their name
    cout << "Enter your name: ";
    cin >> strString;
 
    // Store the name
    Storage<char*> strValue(strString);
 
    // Delete the temporary string
    delete strString;
 
    // Print out our value
    strValue.Print(); // This will print garbage
}

```

As it turns out, instead of printing the name the user input, strValue.Print()prints garbage! What’s going on here?<br>
When Storage is instantiated for type char*, the constructor for Storage<char*> looks like this:

```cpp
Storage<char*>::Storage(char* tValue)
{
     m_tValue = tValue;
}
```

In other words, this just does a pointer assignment! As a result, m_tValue ends up pointing at the same memory location as strString. When we delete strString in main(), we end up deleting the value that m_tValue was pointing at! And thus, we get garbage when trying to print that value.

Fortunately, we can fix this problem using template specialization. Instead of doing a pointer copy, we’d really like our constructor to make a copy of the input string. So let’s write a specialized constructor for datatype char* that does exactly that:

```cpp
Storage<char*>::Storage(char* tValue)
{
    // Allocate memory to hold the tValue string
    m_tValue = new char[strlen(tValue)+1];
    // Copy the actual tValue string into the m_tValue memory we just allocated
    strcpy(m_tValue, tValue);
}

```

Now when we allocate a variable of type Storage<char*>, this constructor will get used instead of the default one. As a result, m_tValue will receive its own copy of strString.<br>
Consequently, when we delete strString, m_tValue will be unaffected.
However, this class now has a memory leak for type char*, because m_tValue will not be deleted when the Storage variable goes out of scope.<br>
As you might have guessed, this can also be solved by specializing the Storage<char*> destructor:

```cpp
Storage<char*>::~Storage()
{
    delete [] m_tValue;
}
```

Now when variables of type ~Storage<char*> go out of scope, the memory allocated in the specialized constructor will be deleted in the specialized destructor.

###### reference:[LearnCPP](http://www.learncpp.com/cpp-tutorial/144-expression-parameters-and-template-specialization/)

----------------

#### Class template specilization

As it turns out, it is not only possible to specialize member functions of a template class, it is also possible to specialize an entire class!<br>
Consider the case where you want to design a class that stores 8 objects. Here’s a simplified class to do so:

```cpp
template <typename T>
class Storage8
{
private:
    T m_tType[8];
 
public:
    void Set(int nIndex, const T &tType)
    {
        m_tType[nIndex] = tType;
    }
 
    const T& Get(int nIndex)
    {
        return m_tType[nIndex];
    }
};

```

Because this class is templated, it will work fine for any given type:

```cpp
int main()
{
    // Define a Storage8 for integers
    Storage8<int> cIntStorage;
 
    for (int nCount=0; nCount<8; nCount++)
        cIntStorage.Set(nCount, nCount);
 
    for (int nCount=0; nCount<8; nCount++)
        std::cout << cIntStorage.Get(nCount) << std::endl;
 
    // Define a Storage8 for bool
    Storage8<bool> cBoolStorage;
    for (int nCount=0; nCount<8; nCount++)
        cBoolStorage.Set(nCount, nCount & 3);
 
    for (int nCount=0; nCount<8; nCount++)
        std::cout << (cBoolStorage.Get(nCount) ? "true" : "false") << std::endl;
 
    return 0;
}

```

This example prints:
0
1
2
3
4
5
6
7
false
true
true
true
false
true
true
true

While this class is completely functional, it turns out that the implementation of Storage8<bool> is much more inefficient than it needs to be.<br>
Because all variables must have an address, and the CPU can’t address anything smaller than a byte, all variables must be at least a byte in size.<br>
Consequently, a variable of type bool ends up using an entire byte even though technically it only needs a single bit to store its true or false valu!<br>
Thus, a bool is 1 bit of useful information and 7 bits of wasted space. Our Storage8<bool> class, which contains 8 bools, is 1 byte worth of useful information and 7 types of wasted space.

As it turns out, using some basic bit logic, it’s possible to compress all 8 bools into a single byte, eliminating the wasted space altogether. <br>
However, in order to do this, we’ll effectively need to essentially revamp the class, replacing the array of 8 bools with a variable that is a single byte in size. <br>
While we could create an entirely new class to do so, this has one major downside: we have to give it a different name. <br>
Then the programmer has to remember that Storage8<T> is meant for non-bool types, whereas Storage8Bool (or whatever we name the new class)is meant for bools.<br>
That’s needless complexity we’d rather avoid. Fortunately, C++ provides us a better method: class template specialization.

##### Class template specialization

Class template specialization allows us to specialize a template class for a particular data type (or set of data types, if there are multiple templated parameters).<br> 
In this case, we’re going to use class template specialization to write a customized version of Storage8<bool> that will take precedence over the generic Storage8<T> class.

Class template specializations are treated as completely independent classes, even though they are allocated in the same way as the templated class. 
This means that we can change anything and everything about our specialization class, including the way it’s implemented and even the functions it makes public, just as if it were an independent class. Here’s our specialized class:

```cpp
template <> // the following is a template class with no templated parameters
class Storage8<bool> // we're specializing Storage8 for bool
{
// What follows is just standard class implementation details
private:
    unsigned char m_tType;
 
public:
    void Set(int nIndex, bool tType)
    {
        // Figure out which bit we're setting/unsetting
        // This will put a 1 in the bit we're interested in turning on/off
        unsigned char nMask = 1 << nIndex;
 
        if (tType)  // If we're setting a bit
            m_tType |= nMask;  // Use bitwise-or to turn that bit on
        else  // if we're turning a bit off
            m_tType &= ~nMask;  // bitwise-and the inverse mask to turn that bit off
    }
 
    bool Get(int nIndex)
    {
        // Figure out which bit we're getting
        unsigned char nMask = 1 << nIndex;
        // bitwise-and to get the value of the bit we're interested in
        // Then implicit cast to boolean
        return m_tType & nMask;
    }
};

```

First, note that we start off with template<>. The template keyword tells the compiler that what follows is templated, and the empty angle braces means that there aren’t any template parameters.<br> 
In this case, there aren’t any template parameters because we’re replacing the only template parameter (typename T)with a specific type (bool).
Next, we add <bool> to the class name to denote that we’re specializing a bool version of Storage8.

All of the other changes are just class implementation details. You do not need to understand how the bit-logic works in order to use the class (though here’s a link to the lesson on bitwise operators if you want to figure it out, but need a refresher on how bitwise operators work).
Note that this specialization class utilizes a single unsigned char (1 byte)instead of an array of 8 bools (8 byte).
Now, when we declare a class of type Storage8<T>, where T is not a bool, we’ll get a version stenciled from the generic templated Storage8<T> class. <br>
When we declare a class of type Storage8<bool>, we’ll get the specialized version we just created. Note that we have kept the publicly exposed interface of both classes the same — while C++ gives us free reign to add, remove, or change functions of Storage8<bool> as we see fit, keeping a consistent interface means the programmer can use either class in exactly the same manner.

We can use the exact same example as before to show both Storage8<T> and Storage8<bool> being instantiated:

```cpp
int main()
{
    // Define a Storage8 for integers (instantiates Storage8<T>, where T = int)
    Storage8<int> cIntStorage;
 
    for (int nCount=0; nCount<8; nCount++)
        cIntStorage[nCount] = nCount;
 
    for (int nCount=0; nCount<8; nCount++)
        std::cout << cIntStorage[nCount] << std::endl;
 
    // Define a Storage8 for bool  (instantiates Storage8<bool> specialization)
    Storage8<bool> cBoolStorage;
    for (int nCount=0; nCount<8; nCount++)
        cBoolStorage.Set(nCount, nCount & 3);
 
    for (int nCount=0; nCount<8; nCount++)
        std::cout << (cBoolStorage.Get(nCount) ? "true" : "false") << std::endl;
 
    return 0;
}
```

As you might expect, this prints the same result as the previous example that used the non-specialized version of Storage8<bool>:
0
1
2
3
4
5
6
7
0
1
2
3
4
5
6
7
false
true
true
true
false
true
true
true

It’s worth noting again that keeping the public interface between your template class and all of the specializations identical is generally a good idea, as it makes them easier to use — however, it’s not strictly necessary.

###### reference:[LearnCPP](http://www.learncpp.com/cpp-tutorial/145-class-template-specialization/)

--------------------

#### Partial template specialization

In the lesson on expression parameters and template specialization, you learned how expression parameters could be used to parametrize template classes.

Let’s take another look at the Buffer class we used in the previous example:

```cpp
template <typename T, int nSize> // nSize is the expression parameter
class Buffer
{
private:
    // The expression parameter controls the side of the array
    T m_atBuffer[nSize];
 
public:
    T* GetBuffer() { return m_atBuffer; }
 
    T& operator[](int nIndex)
    {
        return m_atBuffer[nIndex];
    }
};
 
int main()
{
    // declare a char buffer
    Buffer<char, 10> cChar10Buffer;
 
    // copy a value into the buffer
    strcpy(cChar10Buffer.GetBuffer(), "Ten");
 
    return 0;
}
```

Now, let’s say we wanted to write a function to print out a buffer as a string. Although we could implement this as a member function, we’re going to do it as a non-member function instead because it will make the successive examples easier to follow.

Using templates, we might write something like this:
	
```cpp
template <typename T, int nSize>
void PrintBufferString(Buffer<T, nSize> &rcBuf)
{
    std::cout << rcBuf.GetBuffer() << std::endl;
}

```

This would allow us to do the following:

```cpp
int main()
{
    // declare a char buffer
    Buffer<char, 10> cChar10Buffer;
 
    // copy a value into the buffer
    strcpy(cChar10Buffer.GetBuffer(), "Ten");
 
    // Print the value
    PrintBufferString(cChar10Buffer);
    return 0;
}
```

and get the following result:

Ten

Although this works, it has a design flaw. Consider the following:
	
```cpp
int main()
{
    // declare an int buffer
    Buffer<int, 10> cInt10Buffer;
 
    // copy values into the buffer
    for (int nCount=0; nCount < 10; nCount++)
        cInt10Buffer[nCount] = nCount;
 
    // Print the value?
    PrintBufferString(cInt10Buffer); // what does this mean?
    return 0;
}
```

This program will compile, execute, and produce the following value (or one similar):

0012FF10

What happened? PrintBufferString() has std::cout print the value of rcBuf.GetBuffer(), which returns a pointer to m_atBuffer! When the data type is a char, cout will print the array as a C-style character string, but when the data type is non-char (such as in this case), cout will print the address that the pointer is holding!

Obviously this case exposes a misuse of this function (as written). Without explicitly examining the code, the programmer would not have any clue that this function does not handle non-char buffers correctly. This is likely to lead to programming errors.

###### Template specialization

One seemingly useful way to solve this problem is to use template specialization to ensure that only arrays of type char can be passed to PrintBufferString(). As you learned in the previous lesson, template specialization allows you to define a function where all of the templated types have been resolved to a specific data type.

Here’s an example of how that might work here:

```cpp
void PrintBufferString(Buffer<char, 10> &rcBuf)
{
    std::cout << rcBuf.GetBuffer() << std::endl;
}
 
int main()
{
    // declare a char buffer
    Buffer<char, 10> cChar10Buffer;
 
    // copy a value into the buffer
    strcpy(cChar10Buffer.GetBuffer(), "Ten");
 
    // Print the value
    PrintBufferString(cChar10Buffer);
    return 0;
}
```

As you can see, we’ve now specialized PrintBufferString so it will only accept Buffers of type char and of length 10. This means if we try to call PrintBufferString with an int buffer, the compiler will give us an error.

Although this solves the issue of making sure PrintBufferString can not be called with an int Buffer, it brings up another problem: using full template specialization means we have to explicitly define the length of the buffer this function will accept! Consider the following example:

```cpp
int main()
{
    Buffer<char, 10> cChar10Buffer;
    Buffer<char, 11> cChar11Buffer;
 
    strcpy(cChar10Buffer.GetBuffer(), "Ten");
    strcpy(cChar11Buffer.GetBuffer(), "Eleven");
 
    PrintBufferString(cChar10Buffer);
    PrintBufferString(cChar11Buffer); // this will not compile
 
    return 0;
}
```

Trying to call PrintBufferString() with cChar11Buffer will not work, because cChar11Buffer is a class of type Buffer<char, 11>, and PrintBufferString() only accepts classes of type Buffer<char, 10>. Even though Buffer<char, 10> and Buffer<char, 11> are both templated from the generic Buffer class, the different template parameters means they are treated as different classes, and can not be intermixed.

Although we could make a copy of PrintBufferString() that could handle Buffer<char, 11>, what happens when we want to call PrintBufferString() will a buffer of size 5, or 14? We’d have to copy the function for each different Buffer size we wanted to use.

Obviously full template specialization is too restrictive a solution here. The solution we are looking for is partial template specialization.

###### Partial template specialization

Partial template specialization allows us to write functions where some of the template parameters have been fully or partially resolved. In this case, the ideal solution would be to allow PrintBufferString() to accept char Buffers of any length. That means we have to specialize the templated data type, but leave the length in templated form. Fortunately, partial template specialization allows us to do just that!

```cpp
template<int nSize>
void PrintBufferString(Buffer<char, nSize> &rcBuf)
{
    std::cout << rcBuf.GetBuffer() << std::endl;
}
```

As you can see here, we’ve explicitly declared that this function will only work for Buffers of type char, but nSize is still a templated parameter, so it will work for char buffers of any size. That’s all there is to it!

Consider the following example:

```cpp
int main()
{
    // declare an integer buffer with room for 12 chars
    Buffer<char, 10> cChar10Buffer;
    Buffer<char, 11> cChar11Buffer;
 
    // strcpy a string into the buffer and print it
    strcpy(cChar10Buffer.GetBuffer(), "Ten");
    strcpy(cChar11Buffer.GetBuffer(), "Eleven");
 
    PrintBufferString(cChar10Buffer);
    PrintBufferString(cChar11Buffer);
 
    return 0;
}
```

This prints:

Ten
Eleven

Just as we expect.

Partial template specialization for pointers

In the previous lesson on expression parameters and template specialization, we took a look at a simple templated Storage class:

```cpp
using namespace std;
 
template <typename T>
class Storage
{
private:
    T m_tValue;
public:
    Storage(T tValue)
    {
         m_tValue = tValue;
    }
 
    ~Storage()
    {
    }
 
    void Print()
    {
        std::cout << m_tValue << std::endl;;
    }
};
```

We showed that this class had problems when template parameter T was of type char* because of the shallow copy/pointer assignment that takes place in the constructor. In that lesson, we used full template specialization to create a specialized version of the Storage constructor for type char* that allocated memory and created an actual deep copy of tValue. For reference, here’s the fully specialized char* Storage constructor:

```cpp
Storage<char*>::Storage(char* tValue)
{
    // Allocate memory to hold the tValue string
    m_tValue = new char[strlen(tValue)+1];
    // Copy the actual tValue string into the m_tValue memory we just allocated
    strcpy(m_tValue, tValue);
}
```

While that worked great for Storage<char*>, what about other pointer types? It’s fairly easy to see that if T is any pointer type, then we run into the problem of the constructor doing a pointer assignment instead of making an actual copy of the element being pointed to.

Because full template specialization forces us to fully resolve templated types, in order to fix this issue we’d have to define a new specialized constructor for each and every pointer type we wanted to use Storage with! This leads to lots of duplicate code, which as you well know by now is something we want to avoid as much as possible.

Fortunately, partial template specialization offers us a convenient solution. In this case, we’ll use class partial template specialization to define a special version of Storage that works for pointer values:

```cpp
using namespace std;
 
template <typename T>
class Storage<T*> // this is specialization of Storage that works with pointer types
{
private:
    T* m_tValue;
public:
    Storage(T* tValue) // for pointer type T
    {
         m_tValue = new T(*tValue);
    }
 
    ~Storage()
    {
        delete m_tValue;
    }
 
    void Print()
    {
        std::cout << *m_tValue << std::endl;
    }
};
```

And an example of this working:

```cpp
int main()
{
    // Declare a non-pointer Storage to show it works
    Storage<int> cIntStorage(5);
 
    // Declare a pointer Storage to show it works
    int x = 7;
    Storage<int*> cIntPtrStorage(&x);
 
    // If cIntPtrStorage did a pointer assignment on x,
    // then changing x will change cIntPtrStorage too
    x = 9;
    cIntPtrStorage.Print();
 
    return 0;
}
```

This prints the value:

7

The fact that we got a 7 here shows that cIntPtrStorage used the pointer version of Storage, which allocated it’s own copy of the int. If cIntPtrStorage had used the non-pointer version of Storage, it would have done a pointer assignment — and when we changed the value of x, we would have changed cIntPtrStorage’s value too.

Using partial template class specialization to create separate pointer and non-pointer implementations of a class is extremely useful when you want a class to handle both differently, but in a way that’s completely transparent to the end-user.

###### reference:[LearnCPP](http://www.learncpp.com/cpp-tutorial/146-partial-template-specialization/)
