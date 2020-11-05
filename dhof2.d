int addOne(int a) pure {
	return a + 1;
}

int addTwo(int a) pure {
	return a + 2;
}

int function(int) apply(int value) pure {
	return value == 1
		? &addOne
		: &addTwo;
}

int main() {
	return apply(1)(1) + apply(2)(2);
}
