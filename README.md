# CS143 

This repo contains all my learning materials for Stanford CS143 : Compilers.

## Resources

You can see the detailed schedule and resource links on the [course website](http://web.stanford.edu/class/cs143/).

- lecture videos : you can watch the lecture videos on [bilibili](https://www.bilibili.com/video/BV17K4y147Bz?p=17&spm_id_from=pageDriver)

- ppt/ : ppt slides
- exam/ : mid-term exam and final exam with solution
- handouts/ : programming assignment handout and some supplementary materials
- homework/ : handwritten homework with solution
- cool/ : my implementation for the five programming assignments
- cool.tar.gz : clean skeleton code tar ball

## Programming Assignment

### Overview

The most important part of CS143 are five programming assignments. During these assignments, you will implement a compiler for the Class-Object-Oriented-Language (COOL). 

- PA1: write a simple program in COOL
- PA2: write the lexical analyzer for COOL
- PA3: write the parser for COOL
- PA4: semantic analysis for COOL
- PA5: code generation for COOL

### Environment Setup

You can follow [these instruction](https://courses.edx.org/courses/course-v1:StanfordOnline+SOE.YCSCS1+1T2020/9f961242edfb45eba0969a5a7592916d/) to setup your own local develop environment.

### Hint for each Programming Assignments

*Aways read the PA handout and the README under each PA directory first and carefully!*

#### PA1: 

You should read Section 1 - 9 in [COOL mannual](./handouts/cool-manual.pdf) before writing code.

I admit that it is a little bit hard to get used to writing COOL, but PA1 is a good chance for you to get familiar with COOL syntax and it is very helpful for you to write lexer and parser in the following PAs.

#### PA2:

Don't rush to write code. My implementation contains only 200LOC for PA2, and I spent 4-5 hours to learn to use flex and understand the background of COOL.

I recommend you read this [lex tutorial](http://dinosaur.compilertools.net/lex/index.html) thoroughly first.

Then read the Section 10 and Figure 1 in  [COOL mannul](./handouts/cool-manual.pdf).

I also wrote some simple cool programs to do the unit test, you can check the cool/assignents/PA2/mytests directory for more details. 

If you are confident that your lexer is correct, you can use the autograd.sh under the PA2 directory to check. This shell scripts will run the reference lexer and your lexer on the COOL  programs under cool/examples directory and compare their output.

#### PA3

to be available...

