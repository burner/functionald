int apply(int function(int) pure fun
		, int value) pure 
{
	return fun(value);
}

int addOne(int a) pure {
	return a + 1;
}

int main() {
	return apply(&addOne, 1);
}
