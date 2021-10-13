class A {
	f():Int {1};
};

class B inherits A {
	f():String {"1"};
};
class Main {
	p:A <- (new A);
	main() : Object {
		p.f()+1
	};
};
