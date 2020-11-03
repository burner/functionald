import std;

struct Group {
	long id;
	string name;
	long[] members;
}

struct State {
	Group[] groups;
}

State createGroup(State old, string name) {
	Group ng = Group
		( old.groups.empty
		  ? 1
		  : old.groups.map!(g => g.id).maxElement
		, name
		, []
		);
	old.groups ~= ng;
	return old;
}

Nullable!(const(long)) findGroup(ref const(State) old, string name) {
	auto f = old.groups.find!(g => g.name == name);
	return f.empty
		? Nullable!(const(long)).init
		: nullable(f.front.id);
}

State addMember(State old, long groupId, long memId) {
	auto g = old.groups.countUntil!(g => g.id == groupId);
	enforce(g != -1, "Group not found");
	old.groups[g].members ~= memId;
	old.groups[g].members = old.groups[g]
		.members.sort.uniq.array;
	return old;
}

unittest {
	State s;
	s = s.createGroup("D_Users");

	Nullable!(const(long)) gId = s.findGroup("D_Users");

	s = s.addMember(gId.get(), 1);
}
