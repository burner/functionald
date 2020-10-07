#include <stdlib.h>
#include <assert.h>

int add(int a, int b) {
	return a + b;
}

int mul(int a, int b) {
	return a * b;
}

struct Object {
	int state;
	int (*memberFunction)(int,int);
};

int main() {
	struct Object* obj = (struct Object*)(malloc(sizeof(struct Object)));
	obj->state = 1;
	obj->memberFunction = &add;

	int a = (*obj->memberFunction)(obj->state, 1);
	assert(a == 2);

	obj->memberFunction = &mul;
	obj->state = 2;
	int m = (*obj->memberFunction)(obj->state, 2);
	assert(m == 4);

	return 0;
}
