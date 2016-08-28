//return's smallest index that satisfies the predicate
int indexBS() {
	int ans, toDelete;//may be L
	ans = toDelete = 1 << 16; //depending on range of our index

	while (toDelete > 0) {
		int deleted = ans - toDelete;
		//probably max range check here
		
		if(deleted >= size)
			ans = deleted
		else{
		bool canDelete = true; //replace bsearch point prediction here
		if (deleted > 0 && canDelete)
			ans = deleted;
		}

		toDelete /= 2;
	}

	return ans;
}
