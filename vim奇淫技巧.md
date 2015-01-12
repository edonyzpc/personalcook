advanced skill of vim

* calculator

1. in insert mode, press the key button: `<C-r>=`
2. the following is the caculator expression, for example 37*12
3. press the key button:`<CR>`

total is : `<C-r>=37*12<CR>`

* do the shell cmd

use python interpreter execute current file:`:!python %`

* file manager netrw

type `vim .` you can use vim file browser

* the file direction in vim

1. the symbol of `%` in vim presents the whole direction of the buffer file.
2. `:h` is used to delete the name of current file and keeps the direction.

* the register of vim

1. default register `""`
2. copy register `"0`
3. named register `"a-"z`
4. dark register `"_d`
5. system clipboard `"+,"*`. `"+` register is the same as the system clipboard.
6. in insertion mode, `<C-r>+` paste the copied content. And `"*` register is supported
 by system X11.
7. in Mac OSX and Windows, there is no difference between `"+` and `"*` registers.
