# Customized Fedora Upgrade
----

Personally, Fedora is used in Virtual Machine and tool ``fedup`` is not nice to me. I have to upgrade Fedora manually.

Taken these steps for upgrade:

1. Setup everything for new VM Fedora.(Download OS, Install OS, Set Admin and so on)

2. Configurate the terminal:
    > fonts and color customization

    > copy `.bashrc` and `.bash_profile` from old Fedora into new Fedora

    > check the run command as login shell for active `.bash_profile`

3. Configurate the git:
    > create ssh key:
    >> `ssh-keygen`(go as default set)

    >> add the public key(~/.ssh/id_rsa.pub) generated below into Github account
    
    >> test the public key:
    >>> ssh -T git@github.com

    >>> `Hi someone! You've successfully authenticated, but GitHub does not provide shell access.` for success.

4. Configurate the vim:
    > check vim for installation(maybe `vim-enhance` is needed)

    > copy `.vimrc` from old Fedora into new Fedora

    > copy direction `.vim` from old Fedora into new Fedora

    > remove the git repository and re-git clone the plugins in `~/.vim/bundle/`

    > change the access of files in other directions in .vim

    > open vim and test the plugin if works well

5. copy files from ~/code/ in old Fedora into new Fedora(except github direction)

6. git clone repositories into ~/code/github/

7. link the tools into /usr/bin(updatesys.py, for example)

8. check the packages needed for installation
