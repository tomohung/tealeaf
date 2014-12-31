# Code Review Tips:

## Naming Things
- choose long, descriptive names
- no "p" variables (or any name that could collide with built-in methods)
- sname_case (except class or module names and constants)

## Methods
- do 1 thing
- short
- return with no side effects
  - or, only side effects with no return
- when only outputing info, give it a prefix
- general rule: the method name should be all you need to have a good idea of what it does. No need to refer to implementation.

## Misc
- do/while vs while to eliminate unnecessary var
- no need ot == true or == false

