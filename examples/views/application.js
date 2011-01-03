(function( $ ){

  $.fn.randomPos = function() {
	var height = $(window).height();
	var width = $(window).width() - 300;
	if(width < 0) {
		width = 0
	}
	console.log( Math.random()*width );
	this.css('left', Math.random()*width);
	this.css('top', Math.random()*height);
  };
})( jQuery );

$(document).ready(function() {
   	$(window).resize(function() {
		$("article").each(function(){
			$(this).randomPos();
		});
	});
	$("article").each(function(){
		$(this).randomPos();
		$(this).css("opacity", 0.9);
	});
 });