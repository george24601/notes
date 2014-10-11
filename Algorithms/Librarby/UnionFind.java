	class UnionFind {
		Map<String, Integer> _entries;
		ArrayList<String> _strings;
		ArrayList<Integer> _parents;
		ArrayList<Integer> _rootSizes;

		public UnionFind() {
			_entries = new HashMap<String, Integer>();
			_strings = new ArrayList<String>();
			_parents = new ArrayList<Integer>();
			_rootSizes = new ArrayList<Integer>();
		}

		public void Union(String a, String b) {
			int aIndex = _entries.get(a);
			int bIndex = _entries.get(b);

			if (aIndex < 0 || bIndex < 0)
				return;

			int rootA =FindInternal(aIndex);
			int rootB =FindInternal(bIndex);
			if (rootA  == rootB)
				return; //already unioned, nothing to be done
			_parents.set(rootA, rootB);

			int newRootSize = _rootSizes.get(rootA) + _rootSizes.get(rootB);

			_rootSizes.set(rootA, newRootSize);
			_rootSizes.set(rootB, newRootSize);
		}

		public void Add(String c) {
			
			int newIndex = _parents.size();
			_entries.put(c, newIndex);
			_strings.add(c);
			_parents.add(newIndex);
			_rootSizes.add(1);
		}

		int FindInternal(int index) {
			int current = index;
			int currentParent = _parents.get(current);

			while (currentParent != current) {
				_parents.set(current, FindInternal(currentParent));// path compression
				current = currentParent;
				currentParent = _parents.get(current);
			}

			return currentParent;
		}

		public String Find(String c) {
			int cIndex = _entries.get(c);
			int cParentIndex = FindInternal(cIndex);
			return _strings.get(cParentIndex);
		}
		
		public int GetRootSize(String key)
		{
			int cIndex = _entries.get(key);
			int cParentIndex = FindInternal(cIndex);
			return _rootSizes.get(cParentIndex);
		}
	}

