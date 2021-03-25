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
      while true loop {
         out_string(">");
         command <- in_string();
         stack <- stack.add(command);
         stack.print();
      }
      pool
   };

};
