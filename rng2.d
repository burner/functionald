import std.array : array;
import std.algorithm : map, filter, splitter, count, sort, uniq, joiner;
import std.stdio;
import std.string;

void main() {
	File("rng2.d", "r")
		.byLineCopy
		.map!(l => l.splitter(" "))
		.joiner
		.map!(w => w.strip())
		.filter!(w => !w.empty)
		.array
		.sort
		.uniq
		.count
		.writeln;
}
