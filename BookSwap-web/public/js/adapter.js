function bookItem(bookTitle, bookEdition, bookAuthor) {
		return `
			<li class='BookItem'>
				<div class='InlineBlockElement'>
					<img src="" height="121" width="121">
				</div>
				<div class='InlineBlockElement v-align-top align-right'>
					<div class='BookTitle'>
						<h4>`+bookTitle+`</h4>
					</div>
					<div class='BookEdition'>
						<p>`+bookEdition+`</p>
					</div>
					<div class='BookAuthor align-right'>
						<p class='InlineBlockElement'>by </p>
						<p class='InlineBlockElement'>`+bookAuthor+`</p>
					</div>
				</div>
			</li>
		`;
}
