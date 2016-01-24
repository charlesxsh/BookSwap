var user = {
	signin: false,
	name: undefined,
	email: undefined
}

var bookDetail = {};

var bookItemList = []

$(document).ready(function() {
	console.log('index ready!!');	
	loadPosting();
	addListeners();
});

function loadPosting() {
	console.log('123');
	//load from server
	$.ajax({
		'url': 'all-posting',
		success: function(data) {
			console.log(data);
			var obj = JSON.parse(data);
			obj.forEach(function(item) {
				$('#bookflow').append(bookItem(item.title, item.edition, item.author));
				bookItemList.push(item);
			});
			$('.BookItem').on('click', function() {
				var i = $(this).index();
				console.log(i);
				bookDetail = {
					title: bookItemList[i].title,
					edition: bookItemList[i].edition,
					author: bookItemList[i].author
				}
				window.location.href = 'bookdetail.html';					
			});
		}
	});
}

function addListeners() {
	console.log('123');
	$('#button_signup').on('click', function() {
		window.location.href = "signup.html";
		$('#button_create_account').on('click', function() {
			$('#page_content_container').html("<div id='bookflow'></div>");
			populateBookFlow(bookItem);
		});
	});
}
