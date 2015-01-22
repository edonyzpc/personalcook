### Advanced Skill of Vim

#### * Calculator

1. in insert mode, press the key button: `<C-r>=`
2. the following is the caculator expression, for example 37*12
3. press the key button:`<CR>`

total is : `<C-r>=37*12<CR>`

#### * Do the shell cmd

use python interpreter execute current file:`:!python %`

#### * File manager netrw

type `vim .` you can use vim file browser

#### * The File Direction in Vim

1. the symbol of `%` in vim presents the whole direction of the buffer file.
2. `:h` is used to delete the name of current file and keeps the direction.

#### * The Register of Vim

1. default register `""`
2. copy register `"0`
3. named register `"a-"z`
4. dark register `"_d`
5. system clipboard `"+,"*`. `"+` register is the same as the system clipboard.
6. in insertion mode, `<C-r>+` paste the copied content. And `"*` register is supported by system X11.
7. in Mac OSX and Windows, there is no difference between `"+` and `"*` registers.

#### * Auto Complete

1. use `set completeopt=menu,preview,longest` to display the complete
2. ctags usage

#### * Match in Pattern

1. change the sensibility of upper or lower case
<br>`\c` ignore if the letter is upper or lower case
<br>`\C` can not ignore the upper and lower case
<br> add this into the end of the pattern when it is needed
2. regular expression in vim
<br>`\v`(very magic) help us to treat the regular expression in vim more like Perl,Python and Ruby
<br>...for example searching a hexadecimal expression of color, `/\v#([0-9a-fA-F]{6}|[0-9a-fA-F]{3})`
<br>`\V` is the switch for using orginal charactor
<br>...for example searching for a string "a.k.a." which known as "also know as", `/\V#a.k.a.<CR>`, because in `\v`, the symbol "." has a specialmeaning
<br>`/\v<(\w+)\_s+\1>` , this is a regular expression which is used to find repeat words.
<br>parenthesis `()` will save the thing inside into a tmperary storage, and `\1` is the reference of the storage. `\2`,`\3`... are reference of the parentheses respectively.
<br>`\_s` match with blank charactor or break charactor. 
<br>`<>` is the symbol for delimiting the word
3. match the search
<br>`/` start search and `?` start search in reverse
<br>`n` jumps to the next match and `N` jumps to the last match
<br>use history record to fix the regualr match expression to match the complex task

#### * Substitute Command

1. syntax: <br>
    `:[range]s[ubstitute]/{pattern}/{string}/[falgs]`
2. flags: <br>
    `g` means the whole current line<br>
    `c` provides the ensure to finish the substitute<br>
    `n` do not do the substitute and counter the matches<br>
    `&` remember the last flag<br>
3. example: <br>
    cmd1 `:s/going/scrolling/g` do the substitute in the first match line<br>
    cmd2 `:%s/going/scrolling/g` do the substitute in the all mathces lines<br>
    `to be done`

#### * Global Command

1. syntax: <br>
    `:[range]global[!]/{pattern}/[cmd]`
2. global workd in the whole file other than the current line and the default of [cmd] is `:print`
3. `:global[!]` or `:vglobal` means do the [cmd] with not-match pattern
4. example for convert html to readable txt<br>
    `/\v\<\/?\w+>`<br>
    `:g//d`
5. example for copy the comment of source code into register
    `:g/\v\/\//yank a`
    `:reg a`

#### * Macro

1. record a macro with `q`
2. example: <br>
    a. `qa` \/\/ a for register of vim
    b. `:!python %` \/\/ command to do
    c. `q` \/\/ finish the record
