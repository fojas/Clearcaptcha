var clearcaptcha = clearcaptcha || {};
(function(){

	clearcaptcha.addListen = function(el,evt,func) {
		if (el.addEventListener){
		  el.addEventListener(evt, func, false); 
		} else if (el.attachEvent){
		  el.attachEvent(evt, func);
		}
	}
	clearcaptcha.getInputElementsByClassName = function (c) {
		var r = [];
		var j = 0;
		var o = document.getElementsByTagName('input');
		for(i=o.length;i--;)
		{
			if(o[i].className == c) {
				r[j++]=o[i];
			}
		}
		return r;
	}
	
	var keysPressed = 0;

	clearcaptcha.logKeys = function() {
		//user hit a key, increment the counter
		keysPressed++;
		// Bas van der Graaf (bvdgraaf@e-dynamics.nl) 
		// Get all usedKeyboard inputs and set value
		var elKeyPressed = clearcaptcha.getInputElementsByClassName('inv_ku');
		for (var i=elKeyPressed.length;i--;)
		{
			elKeyPressed[i].value = keysPressed;
		} 
	}
	//capture when a user uses types on their keyboard
	clearcaptcha.addListen(document,'keypress', clearcaptcha.logKeys);


	/* This code will grab two mouse coordinate sets from the user's mouse.
	 * The first set is shortly after the user starts moving thier mouse across the web page.
	 * The second set is grabbed a specified time later.  The distance between the two sets
	 * is calculated and stored in a form field
	 */

	clearcaptcha.timedMousePos = function() {
		//when the user moves the mouse, start working
		document.onmousemove = getMousePos;
		if (xPos >= 0 && yPos >= 0) {
			//0,0 is a valid mouse position, so I want to accept that.  for this reason
			//my vars are initialized to -1
			var newX = xPos;
			var newY = yPos;
			intervals++;
		}
		if (intervals == 1) {
			//store the first coordinates when we've got a pair (not when 'intervals' is 0)
		  firstX = xPos;
	  	firstY = yPos;
		} else if (intervals == 2) {
			//I've got two coordinate sets
			//tell the browser to stop executing the timedMousePos function
	  	clearInterval(myInterval);
			//send the 4 mouse coordinates to the calcDistance function
	  	calcDistance(firstX,firstY,newX,newY);
	  }
	}

	//tell the browser to start executing the timedMousePos function every x milliseconds
	var myInterval = window.setInterval(clearcaptcha.timedMousePos,250)
	
	// Variables for mouse positions
	var xPos = -1;
	var yPos = -1;
	var firstX = -1;
	var firstY = -1;
	// variable to track how many times I polled the mouse position
	var intervals = 0;

	// retrieve mouse x,y coordinates
	var getMousePos = function(p) {
		if (!p) var p = window.event;
		if (p.pageX || p.pageY) {
			xPos = p.pageX;
			yPos = p.pageY;
		}	else if (p.clientX || p.clientY) {
			xPos = p.clientX + document.body.scrollLeft	+ document.documentElement.scrollLeft;
			yPos = p.clientY + document.body.scrollTop + document.documentElement.scrollTop;
		}
	}


	var calcDistance = function(aX,aY,bX,bY) {
		//use the Euclidean 2 dimensional distance formula to calculate the distance 
		//in pixels between the coordinate sets 
		var mouseTraveled = Math.round(Math.sqrt(Math.pow(aX-bX,2)+Math.pow(aY-bY,2)));
		try	{
			var elMouseMovement = clearcaptcha.getInputElementsByClassName('inv_mm');
			for (var i=0;i<elMouseMovement.length;i++)
			{
				elMouseMovement[i].value = mouseTraveled
			} 
		}
		catch(excpt) { /* no action to take */ }
	}
})()