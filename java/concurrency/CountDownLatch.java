public void countDown() {
	sync.releaseShared(1);
}

boolean releaseShared(int arg){
	if(tryReleaseShared(arg)){
		doReleaseShared();
		return true;
	}

	return false;
}

boolean tryReleaseShared(int releases){
	for(;;){
		int c = getState();
		if(c == 0)
			return flase;
		int nextc = c - 1;
		if(casStale(c, enxtC))
			return nextC == 0;
	}
}

void doReleaseShared(){
	for(;;){
		Node h = head;
		if(h!= null && h!= tail){
			//.....
			if(ws == Node.SIGNAL){	
				unparkSuccessor(h);	
			}else if(ws == 0 && !compareWaitSate(h, e9, Node.PROPAGATE))
				continue;
		}
		if(h == head)
			break;
	}
}
