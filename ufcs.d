int theSame(int a) {
	return a;
}

int fun2(int a) {
	return a;
}

unittest {
	fun2(theSame(10));
	10.theSame().fun2();
}
