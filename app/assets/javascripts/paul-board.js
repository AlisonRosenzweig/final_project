(function () {
	var getXY = function (e) {
		var point = {
			x: e.pageX - e.target.parentElement.offsetLeft,
			y: e.pageY - e.target.parentElement.offsetTop,
		};
		return point;
	}
	
	var hackyDragEvent = function(element, handlers) {
		var isMouseDown = false;

		element.addEventListener("mousemove", function (e) {
			if (isMouseDown) {
				handlers.dragMove(getXY(e));
			}
		});

		element.addEventListener("mousedown", function (e) {
			isMouseDown = true;
			handlers.dragStart(getXY(e));
		});

		element.addEventListener("mouseup", function (e) {
			isMouseDown = false;
			handlers.dragEnd(getXY(e));
		});	
	}

	var pointToPathString = function (points) {
		if (points.length === 0) { return "" }
		var path = "M " + points[0].x + " " + points[0].y + " ";
		for (var i=1; i<points.length; i++) {
			var point = points[i];
			path += "L " + point.x + " " + point.y + " ";
		}
		return path;
	}

	window.PaulBoard = function (divElement) {
		var pb = {};
		var svgElement = document.createElementNS("http://www.w3.org/2000/svg", "svg");
		divElement.appendChild(svgElement);

		var newPath = function (points) {
			console.log("new path");
			var element = document.createElementNS("http://www.w3.org/2000/svg", "path");
			svgElement.appendChild(element);
			if (points.length > 0) {
				var pathString = pointToPathString(points);
				element.setAttributeNS(null, "d", pathString);
			}
			return element;
		}

		var currentPathElement = undefined;
		var pointsForCurrentStroke = []
		var dragHandlers = {
			dragMove: function (point) {
				pointsForCurrentStroke.push(point)
				var pathString = pointToPathString(pointsForCurrentStroke);
				currentPathElement.setAttributeNS(null, "d", pathString);
			},
			dragStart: function (point) {
				currentPathElement = newPath([point]);
			},
			dragEnd: function (point) {
				if (pointsForCurrentStroke.length === 1) {
					currentPathElement.remove();
				} else if (paulBoard.drawingStoppedCallback) {
					paulBoard.drawingStoppedCallback(pointsForCurrentStroke)
				}
				currentPathElement = undefined;
				pointsForCurrentStroke = [];
			},
		};

		hackyDragEvent(divElement, dragHandlers)

		pb.drawPoints = newPath

		return pb;
	}
})()
