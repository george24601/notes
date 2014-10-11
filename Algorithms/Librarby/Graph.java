	class Graph
	{
		HashMap<Integer, ArrayList<Integer>> _edges;
		
		public Graph()
		{
			_edges = new HashMap<Integer, ArrayList<Integer>>();
		}
		public void AddEdge(int a, int b)
		{
			if (!_edges.containsKey(a))
				_edges.put(a, new ArrayList<Integer>());
			
			_edges.get(a).add(b);

			if (!_edges.containsKey(b))
				_edges.put(b, new ArrayList<Integer>());
			
			_edges.get(b).add(a);
		}

		public void RemoveEdge(int a, int b)
		{
			_edges.get(a).remove(b);
			_edges.get(b).remove(a);
		}
		
		public void HasEdge (int a, int b)
		{
			if (!_edges.containsKey(a))
				return false;
			return _edges.get(a).contains(b);

		}

		public ArrayList<Integer> GetEdges(int a)
		{
			return _edges.get(a);
			
		}
		
		public int NumNodes()
		{
			return _edges.size();
		}
	}
