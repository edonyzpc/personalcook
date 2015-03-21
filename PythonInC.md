# Use Python In C/C++ Application

> As Python provide C API that help thoes who are good at C but need something that prefer to something that has a good performance at Python.

----

In this note, I will do some record for my configuration of Visual Studion 2008 that refer to Python C API. And my OS is Windows 7 Professional 64bits.

1. Install Python for Windows.<br>
    a. The only thing that we should taking care of is the difference between 32bits-Python and 64bits-Python.<br>
    b. Concretely, since my Visual Studio 2008 built 32bits Application, I choose Python2.7.9-X86-installer. This is very important for linking Python C-API library within my Visual Studio Project.<br>

2. Configuration the Visual Studio Project.<br>
    a. Right-Click the project --> C/C++ --> General --> Additional Include Direction(add the Python C API header file directions)<br>
    b. Right-Click the project --> C/C++ --> General --> PreProcessor(add the line of "MS_NO_COREDLL")<br>
    c. Right-Click the project --> Linker --> General --> Additional Library Direction(add the Python C API *.lib file's direction)<br>
    Right-Click the project --> Linker --> Input --> Additional Dependency(add the name of library.For Python C API, it is "python27.lib","pyexpat.lib")<br>

