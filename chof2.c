int addOne(int a) {
	return a + 1;
}

int addTwo(int a) {
	return a + 2;
}

int (*apply(int value))(int) {
	return value == 1
		? &addOne
		: &addTwo;
}

int main() {
	return (*apply(1))(1) + (*apply(2))(2);
}

