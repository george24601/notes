$(
	function()
	{
		autoDeregister();
		dragDrop();
	}

);

	//take() and takeUtil() will auto deregister when the stream concludes
function autoDeregister()
{
		Rx.Observable.fromEvent($('#button1'), 'click').take(1).forEach(
		function(e){
			alert("event is unregistered. Clicking again has no effect");
		});
}

function dragDrop()
{
	var sprite = $(".sprite")[0];
	var container = $(".container")[0];
	var md = Rx.Observable.fromEvent(sprite, "mousedown");
	var mm = Rx.Observable.fromEvent(container, "mousemove");
	var mu = Rx.Observable.fromEvent(container, "mouseup");

	var drags = md.concatMap(function(point)
				{
					return mm.takeUntil(mu).map (
						function(movePoint){
							return {
								pageX: movePoint.pageX - point.offsetX,
								pageY: movePoint.pageY - point.offsetY,
							};
						});
				});
	drags.forEach(function(point)
					{
						sprite.style.left = point.pageX +"px";
						sprite.style.top = point.pageY +"px";
					}

					);

}


