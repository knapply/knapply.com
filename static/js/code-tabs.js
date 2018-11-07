jQuery(document).ready(function(){
	jQuery("ul.tab-nav button").click(function(e){
		var tab_id = jQuery(this).attr("id");
		jQuery("ul.tab-nav button").removeClass("active");
		$(this).addClass("active");
		jQuery(".tab-container div.tab").hide();
		jQuery(".tab-container div#" + tab_id + "-tab").show();
	});
	jQuery("ul.tab-nav button:first-child").trigger("click");
});