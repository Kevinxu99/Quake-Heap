<!DOCTYPE html>
<html>
<head>
	<title>Home Page</title>
</head>
<body>
	<h1>Welcome</h1>
	<form id='insert'>
	    <label>Insert a node:</label>
	    <input type="text" id = 'nodeVal' name="nodeVal" placeholder="">
	    <input type="submit" value="Insert">
	</form>
    <br>
	<form id='delete'>
    	<label>delete a node:</label>
    	<input type="text" id = 'nodeValDel' name="nodeValDel" placeholder="">
    	<input type="submit" value="Delete">
    </form>

	<div class='canvas'>
	</div>
	<script src="https://code.jquery.com/jquery-3.5.0.js" integrity="sha256-r/AaFHrszJtwpe+tHyNi/XCfMxYpbsRg2Uqn0x3s2zc=" crossorigin="anonymous"></script>
	<script src="https://d3js.org/d3.v5.min.js"></script>
	<script type="application/javascript" src="js/heap.js"></script>
</body>
</html>