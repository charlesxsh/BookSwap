$(document).ready(function() {
		console.log('ready!!');
		populateBookFlow(Adapter.BookItem('Computer Science: A Better Introduction','Me'));
		addListeners();
		sizeAdapter();
	}
);