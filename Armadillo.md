# Using Armadillo Linear Library

> Armadillo is a high quality C++ linear algebra library, aiming towards a good balance between speed and ease of use; the syntax (API) is deliberately similar to Matlab.[reference from http://arma.sourceforge.net/]

----

In this note, I will do some record for my configuration of Visual Studion 2008 that refer to Armadillo Linear Library. And my OS is Windows 7 Professional 64bits.

----

1. Install Armadillo Linear Library for Windows.<br>
        Downdload Armadillo Linear Library from http://arma.sourceforge.net/download.html.<br>
        The only thing that we should taking care of is that the Armadillo Linear Library has requirement of compiler and the compiler of Visual Studio 2008 is match with the version of <=4.000.0.<br>

2. Configuration the Visual Studio Project.<br>
        Right-Click the project --> C/C++ --> General --> Additional Include Direction(add the Armadillo library header file directions)<br>
        Right-Click the project --> Linker --> General --> Additional Library Direction(add the BLSA and LAPACK .*lib and *.dll directions)<br>
        Right-Click the project --> Linker --> Input --> Additional Dependency(add the name library of BLSA and LAPACK.)<br>
        Copy the LAPACK *.dll files into your project direction.<br>
        Go to the direction of Armadillo Library($ArmadilloDirection\include\armadillo_bits\) and find the file "config.hpp".If you have LAPACK and BLAS (or OpenBLAS) present, uncomment the following the lines:<br>
----

        #define ARMA_USE_LAPACK
        #define ARMA_USE_BLAS
