(function () {
	var hackyDragEvent = function(element, handlers) {
		var isMouseDown = false;

		element.addEventListener("mousemove", function (e) {
			if (isMouseDown) {
				handlers.dragMove(e.offsetX, e.offsetY);
			}
		});

		element.addEventListener("mousedown", function (e) {
			isMouseDown = true;
			handlers.dragStart(e.offsetX, e.offsetY);
		});

		element.addEventListener("mouseup", function (e) {
			isMouseDown = false;
			handlers.dragEnd(e.offsetX, e.offsetY);
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
			dragMove: function (x, y) {
				pointsForCurrentStroke.push({x: x, y: y})
				var pathString = pointToPathString(pointsForCurrentStroke);
				currentPathElement.setAttributeNS(null, "d", pathString);
			},
			dragStart: function (x, y) {
				currentPathElement = newPath([]);
			},
			dragEnd: function (x, y) {
				if (pointsForCurrentStroke.length === 0) {
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

