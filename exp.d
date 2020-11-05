import std;
import std.range : take;

struct Exp {
	@property int front() {
		throw new Exception("");
	}

	@property bool empty() { 
		return false;
	}

	void popFront() { }
}

unittest {
	Exp e;
	assertThrown(e.map!(i => 2).array);
}

unittest {
	Exp e;
	int[] r = e
		.handle!(Exception, RangePrimitive.front, (e, r) => 0)
		.take(2)
		.map!(i => i * 2)
		.array;
}

unittest {
	import std.conv : to;
	import std.typecons : nullable, Nullable;
	string s = "12,1337z32,54,2,7,9,1z,6,8";

	int[] i = s.splitter(",")
		.map!(n => {
			try {
				return to!int(n).nullable();
			} catch(Exception e) {
				return Nullable!(int).init;
			}
		}())
		.filter!(n => !n.isNull)
		.map!(n => n.get())
		.array;
}

unittest {
	import std.conv : to;
	import std.typecons : nullable, Nullable;

	Nullable!int parse(string s) nothrow {
		try {
			return to!int(s).nullable();
		} catch(Exception e) {
			return Nullable!(int).init;
		}
	}

	string s = "12,1337z32,54,2,7,9,1z,6,8";

	int[] i = s.splitter(",")
		.map!(n => parse(n))
		.filter!(n => !n.isNull)
		.map!(n => n.get())
		.array;
}
