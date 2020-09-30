function set_default_background_for_audience_cells() {
	
	var allowance_clickable_switchers_array = document.getElementsByClassName("allowance_clickable_switcher");
	
	for (var i=0; i<allowance_clickable_switchers_array.length; i++) {
		allowance_clickable_switchers_array[i].style.backgroundColor="rgb(67, 255, 0)";
		allowance_clickable_switchers_array[i].style.color="rgba(0, 0, 0, 0.3)";
	};
};

function switch_value(clicked_id) {
	if (document.getElementById(clicked_id).style.backgroundColor=="rgb(102, 102, 102)") {
		document.getElementById(clicked_id).style.backgroundColor="rgb(67, 255, 0)";
		document.getElementById(clicked_id).style.color="rgba(0, 0, 0, 0.3)";
	} else if (document.getElementById(clicked_id).style.backgroundColor=="rgb(67, 255, 0)") {
		document.getElementById(clicked_id).style.backgroundColor="rgb(102, 102, 102)";
		document.getElementById(clicked_id).style.color="rgba(255, 255, 255, 0.2)";
	} else {
		document.getElementById(clicked_id).style.backgroundColor="rgb(0, 0, 255)";
		alert("Error. " + document.getElementById(clicked_id).style.backgroundColor);
		document.getElementById(clicked_id).style.color="rgb(255, 255, 255)";
	};
};



var init_function_var = init_function();

document.onload = init_function_var;

function init_function() {
	var buttonClick = document.getElementsByClassName("zeroise_allowances_button");

	[].slice.call(buttonClick).forEach(function(item) {
		item.addEventListener('click', function() {
			var mentioned_user_name = item.id.substring(9, item.id.indexOf("zeroise")-1);
			var mentioned_user_caption = document.getElementById("audience_user_name_div_" + mentioned_user_name).innerHTML;
			if (confirm("Пользователь " + mentioned_user_caption + " больше не будет иметь какой-либо доступ к выбранному списку. Продолжить?")) {
				alert("Пользователь " + mentioned_user_caption + " больше не имеет доступа к выбранному списку.");
			} else {
				alert("Действие отменено.");
			};
		});
	});
};