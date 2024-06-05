# FizzBuzz Enterprise Edition in Delphi
Amusing look at different levels of overengineering FizzBuzz in Delphi's Object Pascal. This is mostly "for fun" but it is also useful to look at when **best practices** *go to far*.  

## What is FizzBuzz
FizzBuzz is a game that has gained in popularity as a programming assignment to weed out non-programmers during job interviews. The object of the assignment is less about solving it correctly according to the below rules and more about showing the programmer understands basic, necessary tools such as if-/else-statements and loops. The rules of FizzBuzz are as follows:

For numbers 1 through 100,

* if the number is divisible by 3 print Fizz;
* if the number is divisible by 5 print Buzz;
* if the number is divisible by 3 and 5 (15) print FizzBuzz;
* else, print the number.

----

## Inspiration
* [The Java editon](https://github.com/EnterpriseQualityCoding/FizzBuzzEnterpriseEdition) (I believe the original)
  * 89 Java files
  * with 2126 lines
    * 496 blank
    * 739 comments
    * 1386 code   
* [The C# Edition](https://github.com/jongeorge1/FizzBuzzEnterpriseEdition-CSharp)
  * 48 C# files
  * Over 6 projects
  * with 1538 C# lines
    * 122 blank
    * 840 commnets
    * 698 code
  * 6 MSBuild scripts
    * 42 comments
    * 368 code
    * 410 total lines
