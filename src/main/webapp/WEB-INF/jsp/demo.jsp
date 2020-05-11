<!DOCTYPE html>
<html>
<head>
	<title>Quake Heap</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/navbar.css">
	<link rel="stylesheet" type="text/css" href="css/demo.css">
	<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap" rel="stylesheet">
	<script src="https://kit.fontawesome.com/45bd1cd9ae.js" crossorigin="anonymous"></script>
</head>
<body>
	<nav class="navbar navbar-expand-md navbar-light navbar-custom">
		<div class="container">
			<a class="navbar-brand" href="/">Quake Heap</a>
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

	<header class="bg-primary text-white">
        <div class="container text-center">
            <p> A better way to do heaps. Based on a <a href="http://tmc.web.engr.illinois.edu/heap_ianfest.pdf" style="color:yellow">paper</a> by <a href="http://tmc.web.engr.illinois.edu/" style="color:yellow">Timothy Chan </a> </p>
        </div>
    </header>

    <div class="container mt-3">
        <div class="row">
            <form class="form-inline col-lg-4 col-md-6 col-12" id='insert'>
              <div class="form-group mx-3 mb-2">
                <input type="number" class="form-control form-control-sm" id = "nodeVal" placeholder="Insert a node">
              </div>
              <button type="submit" class="btn btn-outline-dark btn-sm mb-2">Insert</button>
            </form>
            <form class="form-inline col-lg-4 col-md-6 col-12" id='delete'>
              <div class="form-group mx-3 mb-2">
                <input type="number" class="form-control form-control-sm" id = "nodeValDel" placeholder="Delete a node">
              </div>
              <button type="submit" class="btn btn-outline-dark btn-sm mb-2">Delete</button>
            </form>
            <div class="col-lg-2 col-md-6 col-12">
                <button type="button" class="btn btn-outline-dark btn-sm mb-2 ml-3" data-toggle="modal" data-target="#decModal">Decrease Key</button>
            </div>
            <div class="col-lg-2 col-md-6 col-12">
                <button type="button" class="btn btn-outline-dark btn-sm mb-2 ml-3" id="extract">Extract Min</button>
            </div>
        </div>
    </div>

    <div class='canvas'>
    </div>

    <div class="modal fade" id="decModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalLabel">Decrease Key</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>

          <div class="modal-body pt-0">
            <form class="form" role="form" id="decrease">
              <div class="form-group mb-0">
                <label for="nodeDec" class="col-form-label">Decrease</label>
                <input type="number" class="form-control form-control-sm" id="nodeDec">
              </div>
              <div class="form-group mb-0">
                <label for="valDec" class="col-form-label">to</label>
                <input type="number" class="form-control form-control-sm" id="valDec">
              </div>
            </form>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline-dark btn-sm mb-2" id="confirm">Confirm</button>
          </div>
        </div>
      </div>
    </div>

    <footer class="py-3 bg-dark">
        <div class="container text-center">
            <a class="m-0 text-center text-white" href="https://github.com/Kevinxu99/Quake-Heap">Developed by Kevin Xu and Naman Chimnani</a>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.4.1.js" integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
    <script src="https://d3js.org/d3.v5.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/d3/5.7.0/d3.min.js"></script>
    <script type="application/javascript" src="js/heap.js"></script>
</body>
</html>