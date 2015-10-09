/*
   Common asynch behavior in the app: startup, play, data access, animation, view/model binding....

   Common asynch problems:
   1.Memory leak
   forget to detach event handler
   2.Race condition
   Response for a later event comes back before the response of an eariler event
   3.Coordindate callbacks in the program
   Split up algorithms so that it can be resumed after the asynch call
   4.Complex state machins
   Needed to track if the call is complete or not
   5.Error handling
   Try-catch useless in asynch settings
 */

//Typical asych code
function play(movieId, cancelButton, callback)
{
	var movieTicket, playError, tryFinish = function()
	{
		if(playError)
			callback(null, playError);
		else if(movieTicket && player.initialized)
			//first wait for ticket and player, both asynch
			callback(null, ticket);//ready to play
	};

	cancelButton.addEventListener("click", function()  {playError = "cancelled";}
			if(!player.intialized)
			{
				player.init(function(error)
					{
						playError = error;
						tryFinish();
					});

				authorizeMovie(fuction(error, ticket)
					{
						playError = error;
						movieTicket = ticket;
						tryFinish();
					});
			});

	//bug: the click event handler is not deregistered!
}	

/*
   iterator pattern: enables data consumer to pull, i.e., iterator.next()

   observer: producer iterates the consumer
   */

//sample: get top rated films (standard functional programming)

var getTopRatedFiles = users=>
	user.videoLists.map(videoList => 
			videoList.videos.filter(video => 
				video.rating == 5.0)).concatAll();

getTopRatedFilms(user).forEach(film => console.log(film));

//now create a drags collection event

var getElementDrags = elmt=>
	elmt.mouseDowns.map(mouseDown => 
			document.mouseMoves.takeUntil(document.mouseUps)).concatAll();
//mousedowns => all mousedowns from now to eternity
//and for each of them, return all mousemoves from now to eternity
//takeUntil, collection ends when a mouseup happens
//concat => all moves between mouseDown and mouseUp

getElementDrags(image).foreach(pos => image.position =pos); //events on the dom object (image) is a first-class collection

/*
 new type: obserable => collection + time
 can model events, animations, async IO, i.e., most of UI actions
   */

//1.Events to Observable
var mouseMoves = Observable.fromEvent(element, "mousemove");
//2.subscribe
var subscription = mouseMoves.forEach(console.log);
//3.unsub
subscription.dispose();
//iterator has two semantics observer doesnt have
//1. could tell consumer there is no more date
//2. can tell consumer there is error
mouseMoves.forEach(event => console.log(event), //next
		error => console.error(error), //error
		() => console.log("done")); //completed



/*
 what does it mean to concat an observable of observable?
a sequence of values where each value is also a sequence of values
so contactAll-like functions will enforce the order in the final collection and solve the race condition
e.g.
 ({1}, {2,3}, {4}} 
 order of arrival: 1, 2, 4, 3 
 => concatAll will produce {1,2,3,4}
 => mergeAll produce in the order of they arrive, i.e., {1,2, 4, 3}
 =>switchLatest gets the first element in each sub-collection, and then listen to the next collection, i.e. {1,2,4}

*/

/*
   TakeUntil: take source collection until stop collection has something
   {source}.takeUntil({stop});

 auto complete box: Two major problems
 1.wait for certain time and send one quest
 2.if i type "ab", response to "a" may comeback after "ab", i.e., stale data on top of new data
 */

var serachResultsets =
	keyPresses.throttle(250). //solve the 1st concertion
	map(key =>
			getJSON("/searchresults?q=" + input.value)//returns observable (with one element)
			.retry(3).
			takeUntil(keyPresses)). //if another key is pressed (keyPresses not empty), the JSON observable will complete even if it is still being processed and will remain empty
	concatAll();

/*

Alternatively

var serachResultsets =
	keyPresses.throttle(250). //solve the 1st concertion
	map(key =>
			getJSON("/searchresults?q=" + input.value)//returns observable (with one element)
			.retry(3)).switchLatest() 
   */

searchresultSets.forEach(
		resultSet => updateSearchResults(resultSet),
		error => showMessage("server down"));


//first example rewritten as observables

var authorizations =
player.init().
map(() =>  //map is applied to an observable
		playAttempts.
		map(movieId =>
			player.authorize(movieId).
			catch(e => Observable.empty).
			takeUntil(cancels)).
		concatAll()).
concatAll();

authorizations.forEach(
		license => player.play(license),
		error => showDialog("can't play"));


/* 
 Comparision with promises
 1. Promises are overused
 2. Hot data source problem: work is being done even when we are not listening to
 i.e., too eager. Observable is lazy evalutaion
 3. Promises can not retry (Have to create a new one)
 4. Promises can not cancel,e.g, timeout problem

 Promises are the eventual VALUE of asynchronous request.
 Observable is the PROCESS of getting that value.
   */


