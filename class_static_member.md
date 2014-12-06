#### Static keyword in C

Static variables keep their values and are not destroyed even after they go out of scope.
The static keyword has another meaning when applied to global variables — it changes them from global scope to file scope. 
Because global variables are typically avoided by competent programmers, and file scope variables are just global variables limited to a single file, the static keyword is typically not used in this capacity.

#### Static member variables

Member variables of a class can be made static by using the static keyword. Static member variables only exist once in a program regardless of how many class objects are defined! One way to think about it is that all objects of a class share the static variables.

```cpp
class Something
{
public:
    static int s_nValue;
};
int Something::s_nValue = 1;
 
int main()
{
    Something cFirst;
    cFirst.s_nValue = 2;
    
    Something cSecond;
    std::cout << cSecond.s_nValue;
    
    return 0;
}
```

This program produces the following output:

2

Because s_nValue is a static member variable, s_nValue is shared between all objects of the class. Consequently, cFirst.s_nValue is the same as cSecond.s_nValue. The above program shows that the value we set using cFirst can be accessed using cSecond!

Although you can access static members through objects of the class type, this is somewhat misleading. cFirst.s_nValue implies that s_nValue belongs to cFirst, and this is really not the case. s_nValue does not belong to any object. In fact, s_nValue exists even if there are no objects of the class have been instantiated!

Consequently, it is better to think of static members as belonging to the class itself, not the objects of the class. Because s_nValue exists independently of any class objects, it can be accessed directly using the class name and the scope operator:

```cpp
class Something
{
public:
    static int s_nValue;
};
int Something::s_nValue = 1;
 
int main()
{
    Something::s_nValue = 2;
    std::cout << Something::s_nValue;
    return 0;
}

```

In the above snippet, s_nValue is referenced by class name rather than through an object. Note that we have not even instantiated an object of type Something, but we are still able to access and use Something::s_nValue. This is the preferred method for accessing static members.

#### Initializing static member variables

Because static member variables are not part of the individual objects, you must explicitly define the static member if you want to initialize it to a non-zero value. The following line in the above example initializes the static member to 1:

```cpp
int Something::s_nValue = 1;
```

This initializer should be placed in the code file for the class (eg. Somethinf.cpp). In the absense of an initializing line, C++ will initialize the value to 0. 

#### Static member functions

you learned that classes can have member variables that are shared across all objects of that class type. However, what if our static member variables are private? Consider the following example:

```cpp
class Something
{
private:
    static int s_nValue;
};
int Something::s_nValue = 1;
 
int main()
{
    //do something
}

```

In this case, we can’t access Something::s_nValue directly from main(), because it is private. Normally we access private members through public member functions. While we could create a normal public member function to access s_nValue, we’d then need to instantiate an object of the class type to use the function! We can do better. In this case, the answer to the problem is that we can also make member functions static.

Like static member variables, static member functions are not attached to any particular object. Here is the above example with a static member function accessor:

```cpp
class Something
{
private:
    static int s_nValue;
public:
    static int GetValue() {return s_nValue;}
};
int Something::s_nValue = 1;
 
int main()
{
    std::cout<<Somethin::GetValue()<<std::endl;
}

```

Because static member functions are not attached to a particular object, they can be called directly by using the class name and the scope operator. Like static member variables, they can also be called through objects of the class type, though this is not recommended.

Static member functions have two interesting quirks worth noting. First, because static member functions are not attached to an object, they have no this pointer! This makes sense when you think about it — the this pointer always points to the object that the member function is working on. Static member functions do not work on an object, so the this pointer is not needed.

Second, static member functions can only access static member variables. They can not access non-static member variables. This is because non-static member variables must belong to a class object, and static member functions have no class object to work with!

Here's another example using static member variable and functions:

```cpp
class IDGenerator
{
private:
    static int s_nNextID;
     
public:
     static int GetNextID() {return s_nNextID++;}

};
int IDGenerator::s_nNextID = 1;
 
int main() 
{
    for (int i=0; i < 5; i++)
        cout << "The next ID is: " << IDGenerator::GetNextID() << endl;

    return 0;
}
```

Note that because all the data and functions in this class are static, we don’t need to instantiate an object of the class to make use of it’s functionality! This class utilizes a static member variable to hold the value of the next ID to be assigned, and provides a static member function to return that ID and increment it.

Be careful when writing classes with all static members like this. Although such “pure static classes” can be useful, they also come with some potential downsides. First, because all of the members belong to the class, and the class is accessible from anywhere in the program, it’s essentially the equivalent of declaring a global variable of the class type. In the section on global variables, you learned that global variables are dangerous because one piece of code can change the value of the global variable and end up breaking another piece of seemingly unrelated code. The same holds true for pure static classes. Second, because all static members are instantiated only once, there is no way to have multiple copies of a pure static class (without cloning the class and renaming it). For example, if you needed two independent IDGenerators, this would not be possible.
