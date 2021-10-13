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

   term() : String {
      term
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

   execute() : Stack {
      (
         let cmd : String <- term ,
             arg1 : String,
             arg2 : String,
             newStack : Stack in
         if cmd = "+" then
         ( let func : A2I <- (new A2I) in
         {
            newStack <- self.remove();
            arg1 <- newStack.term();
            newStack <- newStack.remove();
            arg2 <- newStack.term();
            newStack <- newStack.remove();
            newStack <- newStack.add(func.i2a(func.a2i(arg1) + func.a2i(arg2)));
         }
         ) else if cmd = "s" then 
         {
            newStack <- self.remove();
            arg1 <- newStack.term();
            newStack <- newStack.remove();
            arg2 <- newStack.term();
            newStack <- newStack.remove();
            newStack <- newStack.add(arg1);
            newStack <- newStack.add(arg2);
         } else self
         fi fi
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
               stack <- stack.execute()
            else stack <- stack.add(command)
            fi fi fi fi fi;
         }
         pool
      )
   };

};
