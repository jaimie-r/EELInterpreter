### PROJECT DESCRIPTION
This is an interpreter for EEL,a “little language” of
expressions. Some of the skills developed through this project are:
• Explicit memory management using the malloc and free calls, which is very different from previous experience with Java.
• Creating and manipulating pointer-based data structures: trees, linked lists, and hash tables. While
pointers in C are similar to references in Java, there are key differences between them.
• Working with strings since there's no String class in C.
• Implementing robust code that operates correctly with invalid arguments, such as NULL pointers. 
This project contains a simple version of an interpreter for
EEL. Most of the code for reading and printing was provided by Siddarth Chatterjee, so my contribution is the
evaluation part of REPL.
• The interpreter handles a core language two data types
(integers and Booleans), literals (i.e., constants, not variables), a handful of unary, binary, and
ternary operations (some overloaded), strings and named variables to create the language EEL-2.

## HOW TO RUN:
* Run `make ci` to get the binary `ci`. Run `make test_week3` to run the test case.
