# Lesson 1 Reflection
  
  Happy new year!!

  Before I talk about where I struggled with, I would like to say something before I join the course.
  I am using C++ for few years, and coding is part of my job. Before join the course, I've also done the [Learn Ruby The Hard Way][]. `Learn Ruby The Hard Way` is also a good pratice, especially for `muscle memory`. It focus on `just typing ruby` when learning ruby knowledge. 
  [Learn Ruby The Hard Way]: http://learnrubythehardway.org/book/
  
  After that, I start `Prep Course` @ tealeaf, reading the book `Introduce to Programing`. `Introduction to Programing` is also an amazing book, it use a simple way to explain more detail in ruby, and I really did several times "Ah ha!" when reading it. Then I thought I was ready for lesson 1, but maybe I'm wrong :p
  
  About the struggles, as a C++ programmer, there are mainly two "What?" for ruby:
  
  - variable scope: in C++, every local variable only survive in its scope, but in ruby, this is not always true. Even now, I'm still a little confused with that. Glad that I find a way to deal with this: `Never use outside variable in insdie scope, make them in different name`.
  
  - pointer & reference: when passing a variable to functions(in ruby called: methods), if varaible has prefix like `*` or `&`, it obvious means this variable may be modified in this methods. Ruby doesn't take this way, input variables in method could be modified just by what action do inside the method. Fotunately, ruby usaually append suffix `!` behind method's name to indicate this method modify input variable.
  
Last, share my experience for developing game `Black Jack`:
  - psuedo code : 10 min
  - coding : 2 hours
  - debugging : 2 hours more
  - feedback from TA, then refactor: 2 hours
  
By the way, the most difficult in Lesson 1 is completing "Tic-Tac-Toe" AI, it tooks me 10 hours more.
