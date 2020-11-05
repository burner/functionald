struct State {
	Data[] data;
	Mutex[long] mutexes;

	void action(ActionData ad
			, long[] mutexIds) 
	{
		mutexIds
			.sort
			.each!(it => this.mutexes[id].lock());

		//
		// perform action
		//

		mutexIds
			.each!(it => this.mutexes[id].unlock());

	}
}
