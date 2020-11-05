import std;

struct Range {
	int from;
	int to;

	@property int front() {
		return this.from;
	}

	@property bool empty() const {
		return this.from >= this.to;
	}

	void popFront() {
		++this.from;
	}
}

unittest {
	foreach(it; Range(0, 10)) {
		writeln(it); // 0, 1, 2, 3, ... , 9
	}
}

unittest {
	for(auto __r = Range(0, 10); !__r.empty; __r.popFront()) {
		auto it = __r.front;

		writeln(it); 
	}
}

unittest {
	import std.array : array;

	int[] a = Range(0, 10).array;
}

struct Map(alias fun) {
	Range range;

	@property int front() {
		return fun(this.range.front);
	}

	@property bool empty() const {
		return this.range.empty;
	}

	void popFront() {
		this.range.popFront();
	}
}

Map!fun map(alias fun)(Range r) {
	return Map!fun(r);
}

unittest {
	auto tt = Range(0, 10).map!(it => it * 2);
	assert(tt.equal([0, 2, 4, 6, 8, 10, 12, 14, 16, 18]));
}

struct Map2(alias fun, R) {
	R range;

	@property int front() {
		return fun(this.range.front);
	}

	@property bool empty() const {
		return this.range.empty;
	}

	void popFront() {
		this.range.popFront();
	}
}

Map2!(fun,R) map2(alias fun, R)(R r) {
	return Map2!(fun,R)(r);
}

unittest {
	import std.range : iota;

	auto tt = iota(0, 10).map2!(it => it * 2);
	assert(tt.equal([0, 2, 4, 6, 8, 10, 12, 14, 16, 18]));
}
