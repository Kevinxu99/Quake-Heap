<!DOCTYPE html>
<html>
<head>
	<title>Home page</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/navbar.css">

</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container">
			<a class="navbar-brand" href="#">Quake Heap</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			 </button>

			<div class="collapse navbar-collapse" id="navbarSupportedContent">
			    <ul class="navbar-nav mr-auto">
			      <li class="nav-item active">
			        <a class="nav-link" href="/">Introduction <span class="sr-only">(current)</span></a>
			      </li>
			      <li class="nav-item active">
			        <a class="nav-link" href="/demo">Demo <span class="sr-only">(current)</span></a>
			      </li>
			    </ul>
		  	</div>
		</div>
	</nav>

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
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.5.0.js" integrity="sha256-r/AaFHrszJtwpe+tHyNi/XCfMxYpbsRg2Uqn0x3s2zc=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://d3js.org/d3.v5.min.js"></script>
    <script type="application/javascript" src="js/heap.js"></script>

</body>
</html>