### Note about Mac Python and its Packages

[Install Python, NumPy, SciPy, and matplotlib on Mac OS X](http://penandpants.com/2012/02/24/install-python/)

1. Your Mac must already install Xcode or at least CLT(Command Line Tools)

2. The next step is installing the Homebrew packages management <br>
`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

3. After Homebrew successfully installed, you will check you brew with command `brew doctor`. Official calling there is no need to care much more about for WARNINGS for it is just for domainers. Of course you are yourself manager.


4. Now you can help youself to install Python with the help of brew command. `brew install python`. Take care of this command. It do not need the Admin Access(`sudo`) because brew help youself to differentiate the builtin python and brew-installed python.

5. Mac has a builtin Python but it is not a complete Python and neither update. Personally, I think this is the brew-installed python's advantages. Builtin Python is located in '/usr/bin/python' and brew-installed python is located in '/usr/local/bin/python'. And the third party packages for builtin python is located in '/Library/...' and the brew-installed python is located in '/usr/local/lib'

6. Installing Python Packages is almost use `pip`.For example, install numpy, scipy and matplotlib packages.
* `pip install numpy`
* `pip install scipy`
* `pip install matplotlib`
* check if they are succussfully installed and useful

7. For brew-installed python working perfectly, you should mange the `EXPORT $PATH` within your bash_profile or bashrc. And the details are in the following article. <br>
[MacOSX PATH MANGAGEMENT](http://muttsnutts.github.io/blog/2011/09/12/manage-path-on-mac-os-x-lion/)
