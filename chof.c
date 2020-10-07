int apply(int(*fun)(int), int value) {
	return (*fun)(value);
}

int addOne(int a) {
	return a + 1;
}

int main() {
	return apply(&addOne, 1);
}
