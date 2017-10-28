$(function	()	{	
	
	//Datepicker
	$('#calendar').DatePicker({
		flat: true,
		date: '2014-06-07',
		current: '2014-06-07',
		calendars: 1,
		starts: 1
	});

	//Skycon
	var icons = new Skycons({"color": "white"});
    icons.set("skycon1", "sleet");
    icons.set("skycon2", "partly-cloudy-day");
    icons.set("skycon3", "wind");
    icons.set("skycon4", "clear-day");
    icons.play();

	//Scrollable Chat Widget
	$('#chatScroll').slimScroll({
		height:'230px'
	});

	//Chat notification
	setTimeout(function() {
		$('.chat-notification').find('.badge').addClass('active');
		$('.chat-alert').addClass('active');
	}, 3000);

	setTimeout(function() {
		$('.chat-alert').removeClass('active');
	}, 8000);
	
	$(window).resize(function(e)	{
		// Redraw All Chart
		setTimeout(function() {
			totalVisitChart.redraw();
			plotWithOptions();
		},500);
	});

	$('#sidebarToggleLG').click(function()	{
		// Redraw All Chart
		setTimeout(function() {
			totalVisitChart.redraw();
			plotWithOptions();
		},500);
	});

	$('#sidebarToggleSM').click(function()	{
		// Redraw All Chart
		setTimeout(function() {
			totalVisitChart.redraw();
			plotWithOptions();
		},500);
	});
});
