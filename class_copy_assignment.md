#### The copy constructor and overloading the assignment operator

Although using the assignment operator is fairly straightforward, correctly implementing an overloaded assignment operator can be a little more tricky than you might anticipate. There are two primary reasons for this. First, there are some cases where the assignment operator isn’t called when you might expect it to be. Second, there are some issues in dealing with dynamically allocated memory.

The assignment operator is used to copy the values from one object to another already existing object. The key words here are “already existing”. Consider the following example:

```cpp
Cents cMark(5); // calls Cents constructor
Cents cNancy; // calls Cents default constructor
cNancy = cMark; // calls Cents assignment operator
```

In this case, cNancy has already been created by the time the assignment is executed. Consequently, the Cents assignment operator is called. The assignment operator must be overloaded as a member function.

What happens if the object being copied into does not already exist? To understand what happens in that case, we need to talk about the copy constructor.

#### copy constructor

```cpp
Cents cMark(5); // calls Cents constructor
Cents cNancy = cMark; // calls Cents copy constructor!
```

Because the second statement uses an equals symbol in it, you might expect that it calls the assignment operator. However, it doesn’t! It actually calls a special type of constructor called a copy constructor. A copy constructor is a special constructor that initializes a new object from an existing object.

The difference between the copy constructor and the assignment operator causes a lot of confusion for new programmers, but it’s really not all that difficult. Summarizing:
<<* If a new object has to be created before the copying can occur, the copy constructor is used. 
<<* If a new object does not have to be created before the copying can occur, the assignment operator is used. 

There are three general cases where the copy constructor is called instead of the assignment operator:

1. When instantiating one object and initializing it with values from another object.
2. When passing an object by value. 
3. When an object is returned from a function by value.

In each of these cases, a new variable needs to be created before the values can be copied — hence the use of the copy constructor.

Because the copy constructor and assignment operator essentially do the same job (they are just called in different cases), the code needed to implement them is almost identical.

First, let’s add the copy constructor. Thinking about this logically, because it is a constructor, it needs to be named Cents. Because it needs to copy an existing object, it needs to take a Cents object as a parameter. And finally, because it is a constructor, it doesn’t have a return type. Putting all of these things together, here is our Cents class with a copy constructor.

```cpp
class Cents
{
private:
    int m_nCents;
public:
    Cents(nt nCents=0)
    {
        nCents = nCents;
    }
             
    // Copy constructor
    Cents(t Cents &cSource)
    {
        nCents = cSource.m_nCents;
    }
};
```

A copy constructor looks just like a normal constructor that takes a parameter of the class type. However, there are two things which are worth explicitly mentioning. First, because our copy constructor is a member of Cents, and our parameter is a Cents, we can directly access the internal private data of our parameter. Second, the parameter MUST be passed by reference, and not by value. Can you figure out why?

The answer lies above in the list that shows the cases where a copy constructor is called. A copy constructor is called when a parameter is passed by value. If we pass our cSource parameter by value, it would need to call the copy constructor to do so. But calling the copy constructor again would mean the parameter is passed by value again, requiring another call to the copy constructor. This would result in an infinite recursion(well, until the stack memory ran out and the the program crashed), Fortunately, modern C++ compilers will produce an error if you try to do this:

        error C2652: 'Cents' : illegal copy constructor: first parameter must not be a 'Cents'

The first parameter in this case must be a reference to a Cents!

Now let’s overload the assignment operator. Following the same logic, the prototype and implementation are fairly straightforward:

```cpp
class Cents
{
private:
    int m_nCents;
public:
    Cents(int nCents=0)
    {
        m_nCents = nCents;
    }
             
    // Copy constructor
    Cents(const Cents &cSource)
    {
        m_nCents = cSource.m_nCents;
    }
    Cents& operator= (const Cents &cSource);
};
Cents& Cents::operator= (const Cents &cSource)
{
    // do the copy
    m_nCents = cSource.m_nCents;
         
    // return the existing object
    return *this;
}
```

A couple of things to note here: First, the line that does the copying is exactly identical to the one in the copy constructor. This is typical. In order to reduce duplicate code, the portion of the code that does the actual copying could be moved to a private member function that the copy constructor and overloaded assignment operator both call. Second, we’re returning *this so we can chain multiple assigments together:

```cpp
cMark = cNancy = cFred = cJoe; // assign cJoe to everyone
```

Finally, note that it is possible in C++ to do a self-assignment:

```cpp
cMark = cMark; //valid assignment
```

In these cases, the assignment operator doesn’t need to do anything (and if the class uses dynamic memory, it can be dangerous if it does). It is a good idea to do a check for self-assignment at the top of an overloaded assignment operator. Here is an example of how to do that:

```cpp
Cents& Cents::operator= (const Cents &cSource)
{
    // check for self-assignment by comparing the address of the
    // implicit object and the parameter
    if(cSource == this)
        return *this;

    // do the copy
    m_nCents = cSource.m_nCents;
         
    // return the existing object
    return *this;
}
```

Note that there is no need to check for self-assignment in a copy-constructor. This is because the copy constructor is only called when new objects are being constructed, and there is no way to assign a newly created object to itself in a way that calls to copy constructor.

#### Default memberwise copying

Just like other constructors, C++ will provide a default copy constructor if you do not provide one yourself. However, unlike other operators, C++ will provide a default assignment operator if you do not provide one yourself!

Because C++ does not know much about your class, the default copy constructor and default assignment operators it provides are very simple. They use a copying method known as a memberwise copy (also known as a shallow copy).

#### Shallow vs. deep copying

#### Shallow copying

Because C++ does not know much about your class, the default copy constructor and default assignment operators it provides use a copying method known as a shallow copy (as know as a memberwise copy). A shallow copy means that C++ copies each member of the class individually using the assignment operator. When classes are simple (eg. do not contain any dynamically allocated memory), this works very well.

For example, let’s take a look at our Cents class:

```cpp
class Cents
{
private:
    int m_nCents;
public:
    Cents(int nCents=0)
    {
        m_nCents = nCents;
    }
};
```

When C++ does a shallow copy of this class, it will copy m_nCents using the standard integer assignment operator. Since this is exactly what we’d be doing anyway if we wrote our own copy constructor or overloaded assignment operator, there’s really no reason to write our own version of these functions!

However, when designing classes that handle dynamically allocated memory, memberwise (shallow) copying can get us in a lot of trouble! This is because the standard pointer assignment operator just copies the address of the pointer — it does not allocate any memory or copy the contents being pointed to!

Let’s take a look at an example of this:

```cpp
class MyString
{
private:
    char *m_pchString;
    int m_nLength;

public:
    MyString(char *pchString="")
    {
        // Find the length of the string
        // Plus one character for a terminator
        m_nLength = strlen(pchString) + 1;

        // Allocate a buffer equal to this length
        m_pchString= new char[m_nLength];

        // Copy the parameter into our internal buffer
        strncpy(m_pchString, pchString, m_nLength);

        // Make sure the string is terminated
        m_pchString[m_nLength - 1] = '\0';
    }
    ~MyString() //destructor
    {
        // We need to deallocate our buffer
        delete[] m_pchString;
        // Set m_pchString to null just in case
        m_pchString = 0;
    }

    char* GetString() {return m_pchString;}
    int GetLength(){return m_nLength;}
};
```

The above is a simple string class that allocates memory to hold a string that we pass in. Note that we have not defined a copy constructor or overloaded assignment operator. Consequently, C++ will provide a default copy constructor and default assignment operator that do a shallow copy.

Now, consider the following snippet of code:

```cpp
MyString cHello("Hello world!");
{
    MyString cCopy = cHello;//use the default copy constructor
}
std::cout<<cHello.GetString()<<std::endl;//this will crash
```

We deleted the string that cHello was pointing to, and now we are trying to print the value of memory that is no longer allocated. The root of this problem is the shallow copy done by the copy constructor — doing a shallow copy on pointer values in a copy constructor or overloaded assignment operator is almost always asking for trouble.

#### Deep copying

The answer to this problem is to do a deep copy on any non-null pointers being copied. A deep copy duplicates the object or variable being pointed to so that the destination (the object being assigned to)receives it’s own local copy. This way, the destination can do whatever it wants to it’s local copy and the object that was copied from will not be affected. Doing deep copies requires that we write our own copy constructors and overloaded assignment operators.

Let’s go ahead and show how this is done for our MyString class:

```cpp
// Copy constructor
MyString::MyString(const MyString& cSource)
{
    // because m_nLength is not a pointer, we can shallow copy it
    m_nLength = cSource.m_nLength;
         
    // m_pchString is a pointer, so we need to deep copy it if it is non-null
    if (cSource.m_pchString)
    {
        // allocate memory for our copy
        m_pchString = new char[m_nLength];

        // Copy the string into our newly allocated memory
        strncpy(m_pchString, cSource.m_pchString, m_nLength);
    }
    else
    {
        m_pchString = 0;
    }
}
```

As you can see, this is quite a bit more involved than a simple shallow copy! First, we have to check to make sure cSource even has a string (line 8). f it does, then we allocate enough memory to hold a copy of that string (line 11). Finally, we have to manually copy the string using strncpy()(line 14).

Now let’s do the overloaded assignment operator. The overloaded assignment operator is a tad bit trickier:

```cpp
MyString& MyString::operator=(const MyString& cSource)
{
    // check for self-assignment
    if (&cSource == this)
        return * this;

    // first we need to deallocate any value that this string is holding!
    delete[] m_pchString;
    // because m_nLength is not a pointer, we can shallow copy it
    m_nLength = cSource.m_nLength;
    // now we need to deep copy m_pchString
    if (cSource.m_pchString)
    {
        // allocate memory for our copy
        m_pchString = new char[m_nLength];

        // Copy the parameter the newly allocated memory
        strncpy(m_pchString, cSource.m_pchString, m_nLength);
    }
    else
        m_pchString = 0;
             
    return *this;
}
```

Note that our assignment operator is very similar to our copy constructor, but there are three major differences:

* We added a self-assignment check (line 5)
* We return *this so we can chain the assignment operator (line 26)
* We need to explicitly deallocate any value that the string is already holding (line 9)

When the overloaded assignment operator is called, the item being assigned to may already contain a previous value, which we need to make sure we clean up before we assign memory for new values. For non-dynamically allocated variables (which are a fixed size), we don’t have to bother because the new value just overwrite the old one. However, for dynamically allocated variables, we need to explicitly deallocate any old memory before we allocate any new memory. If we don’t, the code will not crash, but we will have a memory leak that will eat away our free memory every time we do an assignment!

#### Checking for self-assignment

In our overloaded assignment operators, the first thing we do is check for self assignment. There are two reasons for this. One is simple efficiency: if we don’t need to make a copy, why make one? The second reason is because not checking for self-assignment when doing a deep copy will cause problems if the class uses dynamically allocated memory. Let’s take a look at an example of this.

Consider the following overloaded assignment operator that does not do a self-assignment check:

```cpp
// Problematic assignment operator
MyString& MyString::operator=(const MyString& cSource)
{
    // Note: No check for self-assignment!
 
    // first we need to deallocate any value that this string is holding!
    delete[] m_pshString;

    // because m_nLength is not a pointer, we can shallow copy it
    m_nLength = cSource.m_nLength;
         
    // now we need to deep copy m_pchString
    if (cSource.m_pchString)
    {
        // allocate memory for our copy
        m_pchString = new char[m_nLength];

        // Copy the parameter the newly allocated memory
        strncpy(m_pchString, cSource.m_pchString, m_nLength);
    }
    else
        m_pchString = 0;
             
    return *this;

}
```

What happens when we do the following? "cHello = cHello;"

This statement will call our overloaded assignment operator. The this pointer will point to the address of cHello (beacause it's the left operand), and cSource will be a reference to cHello (because it’s the right operand).
Consequently, m_pchString is the same as cSource.m_pchString.

Now look at the first line of code that would be executed: delete[] m_pchString;

This line is meant to deallocate any previously allocated memory in cHello so we can copy the new string from the source without a memory leak. However, in this case, when we delete m_pchString, we also delete cSource.m_pchString! We’ve now destroyed our source string, and have lost the information we wanted to copy in the first place. The rest of the code will allocate a new string, then copy the uninitialized garbage in that string to itself. As a final result, you will end up with a new string of the correct length that contain garbage characters.

The self-assignment check prevents this from happening.

#### Preventing copying

Sometimes we simply don’t want our classes to be copied at all. The best way to do this is to add the prototypes for the copy constructor and overloaded operator= to the private section of your class.

```cpp
class MyString
{
private:
    char *m_pchString;
    int m_nLength;
         
    MyString(const MyString& cSource);
    MyString& operator= (const MyString& cSource);
public:
    //Rest of the code
};
```

In this case, C++ will not automatically create a default copy constructor and default assignment operator, because we’ve told the compiler we’re defining our own functions. Furthermore, any code located outside the class will not be able to access these functions because they’re private.

Summary

<* The default copy constructor and default assignment operators do shallow copies, which is fine for classes that contain no dynamically allocated variables.
<* Classes with dynamically allocated variables need to have a copy constructor and assignment operator that do a deep copy.
<* The assignment operator is usually implemented using the same code as the copy constructor, but it checks for self-assignment, returns *this, and deallocates any previously allocated memory before deep copying.
<* If you don’t want a class to be copyable, use a private copy constructor and assignment operator prototype in the class header. 
