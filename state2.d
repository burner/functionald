import std;

auto deepCopy(T)(ref const(T) old) {
	alias UQ = Unqual!T;
	static if(isBasicType!UQ) {
		return cast()old;
	} else static if(isArray!UQ) {
		alias ET = Unqual!(ElementEncodingType!T);
		ET[] ret;
		foreach(ref it; old) {
			ret ~= deepCopy!(ET)(it);
		}
		return ret;
	} else static if(is(T == struct)) {
		Unqual!T ret;
		foreach(mem; FieldNameTuple!T) {
			__traits(getMember, ret, mem) =
				deepCopy(__traits(getMember, old, mem));
		}
		return ret;
	} else {
		static assert(false, T.stringof);
	}
}

struct Group {
	long id;
	string name;
	long[] members;
}

struct State {
	Group[] groups;
}

State createGroup(ref const State old
		, string name) 
{
	Group ng = Group
		( old.groups.empty
		  ? 1
		  : old.groups
		  	.map!(g => g.id)
			.maxElement
		, name
		, []
		);

	State neu = old.deepCopy();
	neu.groups ~= ng;
	return neu;
}

Nullable!(const(long)) findGroup(
		ref const(State) old
		, string name) 
{
	auto f = old.groups
		.find!(g => g.name == name);

	return f.empty
		? typeof(return).init
		: nullable(f.front.id);
}

State addMember(ref const State old
		, long groupId, long memId) 
{
	auto g = old.groups
		.countUntil!(g => g.id == groupId);
	enforce(g != -1, "Group not found");

	State neu = old.deepCopy();
	neu.groups[g].members ~= memId;
	neu.groups[g].members = neu.groups[g]
		.members.sort.uniq.array;
	return neu;
}

unittest {
	State s;
	s = s.createGroup("D_Users");

	Nullable!(const(long)) gId = s
		.findGroup("D_Users");

	s = s.addMember(gId.get(), 1);
}
