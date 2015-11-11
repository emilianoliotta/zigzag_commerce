ready = function() {
	function isEmpty(val){
	return (val == '');
	}

	var submitButton = $("#submitProduct");

	submitButton.on("click", function(event){
		var title = $("#product_title").val();
		var description = $("#product_description").val()
		var price = $("#product_price").val();
		var quantity = $("#product_quantity").val();
		var location = $("#product_location").val();

		var isTitleCorrect = !isEmpty(title);
		var isDescriptionCorrect = !isEmpty(description);
		var isPriceCorrect = (!isNaN(price) && !isEmpty(price));
		var isQuantityCorrect = (!isNaN(quantity) && !isEmpty(quantity));
		var isLocationCorrect = !isEmpty(location);

		if (isTitleCorrect && isDescriptionCorrect && isPriceCorrect && isQuantityCorrect && isLocationCorrect){
			$("#loading-spinner").append("<div style='padding: 6px 12px; padding-bottom:1em;'><div class='throbber-loader pull-right'>Loading…</div><br></div>");
		}
		else
			return;
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);