<!DOCTYPE html>
<html>
<head>
	<title>Home page</title>
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
	<link rel="stylesheet" type="text/css" href="css/navbar.css">
	<link href="https://fonts.googleapis.com/css2?family=Oswald:wght@300;400;500;700&display=swap" rel="stylesheet">
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

    <section id="runtimes">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h2>Why Quake Heaps?</h2>
                    <p class="lead">Quake heaps provide a heap structure with the following improvements in runtimes compared to regular heaps and binomial heaps:</p>
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Heaps:</th>
                                <th>Regular</th>
                                <th>Binomial</th>
                                <th>Ouake</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Report Min:</td>
                                <td>O(1)</td>
                                <td><--</td>
                                <td><--</td>
                            </tr>
                            <tr>
                                <td>Extract Min:</td>
                                <td>O(log(n))</td>
                                <td><--</td>
                                <td>O(n) but <br>O(log(n)) ammortized</td>
                            </tr>
                            <tr>
                                <td>Insert:</td>
                                <td>O(log(n)) but<br>O(1) ammortized</td>
                                <td><--</td>
                                <td>O(1)</td>
                            </tr>
                            <tr>
                                <td>Decrease Key:</td>
                                <td>O(log(n))</td>
                                <td><--</td>
                                <td>O(1)</td>
                            </tr>
                            <tr>
                                <td>Delete:</td>
                                <td>O(log(n))</td>
                                <td><--</td>
                                <td>O(n) but <br>O(log(n)) ammortized</td>
                            </tr>
                            <tr>
                                <td>Merge/Union:</td>
                                <td>O(n)</td>
                                <td>O(log(n))</td>
                                <td>O(1)</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </section>

    <section id="services" class="bg-light">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h2 class="mt-3">Structure</h2>
                    <p class="lead">Quake heaps are basically a collection of multiple tournament trees (with distinct height most of the time) with a constraint on the sum of each level. The ratio of the num of nodes on level i+1 to i should be less than equal to some alpha value that is set to be between 1/2 and 1.<br> ADD A PICTURE HERE? <br> Now tournament tree is a binary tree like structure with all the data at the root level and at each consecutive level the smaller of the 2 children is chosen. The chosen child is then cloned up (stored using pointers).</p>
                </div>
            </div>
        </div>
    </section>

    <section id="contact">
        <div class="container">
            <div class="row">
                <div class="col-lg-8 mx-auto">
                    <h2 class="mt-3">Methods</h2>
                    <p class="lead"><dl class="row">
                    <dt class="col-sm-3">Report Min</dt>
                    <dd class="col-sm-9">A pointer to the Min element is kept at all time and can be reported in constant time. </dd>

                    <dt class="col-sm-3 text-truncate">Insert</dt>
                    <dd class="col-sm-9">Simply add a Tournament Tree of size 1 and increment the counter for the number of nodes at level 0</dd>

                    <dt class="col-sm-3">Decrease Key</dt>
                    <dd class="col-sm-9">Cut above the highest clone of the element we want to decrease. This might lead us to update min but we can do that in constant time.</dd>

                    <dt class="col-sm-3">Decrease Key</dt>
                    <dd class="col-sm-9">Cut above the highest clone of the element we want to decrease. This might lead us to update min but we can do that in constant time.</dd>

                    <dt class="col-sm-3">Extract Min</dt>
                    <dd class="col-sm-9">Simply a combination of find min and then delete.</dd>

                    <dt class="col-sm-3">Delete</dt>
                    <dd class="col-sm-9">We walk up from the leaf level and delete all the clones we had higher up in the tree. Now we also pay for being lazy in the other operations. We link trees if they are equal heights hence leading us to 1 tree of each size (turns out to be O(log(n)) ammortised). BUT...<br> This can lead us to a alpha violation in comes ...drum roll... the QUAKE operation </dd>

                    <dt class="col-sm-3">Quake</dt>
                    <dd class="col-sm-9">We remove all the nodes, in all trees, above the lowest alpha violation that is found whiel deleting. This seems like O(n) but ammortisation saves the day :) </dd>

                    </dl></p>
                </div>
            </div>
        </div>
    </section>

    <footer class="py-3 bg-dark">
        <div class="container text-center">
            <a class="m-0 text-center text-white" href="https://github.com/Kevinxu99/Quake-Heap">Developed by Kevin Xu and Naman Chimnani</a>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>