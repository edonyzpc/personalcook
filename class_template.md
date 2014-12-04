##### class template
###### class template definition:<br>
```cpp
//declare
template <class T>//or <typename T>
class name
\{
    public:
        void func();
        //details omitted...
    private:
        //details omitted...
};
//definition
template <class T>
void name::func()
\{
    //some expressions omitted...
}
//...
```
------
###### class template instantiation:<br>
when instantiating a template, the compiler creates a new class with the given template argument. For example:<br>
```cpp
template<typename T>
struct Foo
/{
    T bar;
    void doSomething(T param){/*do something*/}
};

// somewhere in a .cpp
Foo<int> f;
```

When reading this line, the compiler will create a new class (let\'s call it Foointa),which is equivalent to the following:<br>
```cpp
struct FooInt
{
    T bar;
    void doSomething(int param){/*do somethin*/}
}
```

Consequently, the compiler needs to have access to the implementation of the methods, to instantiate them with the template argument (in this case int).If these implementations were not in the header, they wouldn\'t be accessible, and therefore the compiler wouldn\'t be able to instantiate the template.

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

Another solution is to keep the implementation separated, and explicitly instantiate all the template instances you\'ll need:

```cpp
// Foo.h

// no implementation
template <typename T> struct Foo {...};

//----------------------
//Foo.cpp

//implementation of Foo\'s methods

//explicit instantiation
template class Foo<int>;
template class Foo<float>;
// You will only be able to use Foo with int or float
```

###### reference:[Stackoverflow](http://stackoverflow.com/questions/495021/why-can-templates-only-be-implemented-in-the-header-file)
