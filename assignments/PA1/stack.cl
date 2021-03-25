(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)

class Stack {
   term : String;
   next : Stack;

   isNil() : Bool {false};

   init(head : String, tail : Stack) : Stack {
      {
         term <- head;
         next <- tail;
         self;
      }
   };

   add(x : String) : Stack {
      (new Stack).init(x, self)
   };
   
   remove() : Stack {
      if self.isNil()
      then
         self
      else
         next
      fi
   };
   
   print() : Object {
      (let io : IO <- (new IO) in
         if next.isNil() 
         then 
            io.out_string(term.concat("\n"))
         else
            {
               io.out_string(term.concat("\n"));
               next.print();
            }
         fi
      )
   };

};

class Nil inherits Stack{
   isNil() : Bool {true};
};

class Main inherits IO {
   stack : Stack <- (new Nil);
   command : String;
   main() : Object {
      (
         let flag : Bool <- true in
         while flag loop {
            out_string(">");
            command <- in_string();
            if command = "+" then
               stack <- stack.add(command)
            else if command = "s" then
               stack <- stack.add(command)
            else if command = "d" then
               stack.print()
            else if command = "x" then
               flag <- false
            else if command = "e" then
               stack <- stack.remove()
            else stack <- stack.add(command)
            fi fi fi fi fi;
         }
         pool
      )
   };

};
