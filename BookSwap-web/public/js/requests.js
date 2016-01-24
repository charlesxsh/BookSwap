$(document).ready(function() {
	console.log('ready!!');
	$.ajax({
		'url': 'all-requests',
		success: function(data) {
			console.log(data);
			var obj = JSON.parse(data);
			obj.forEach(function(item) {
				$('#bookflow').append(bookItem(item.title, item.edition, item.author));
			});
		}
	});
});
