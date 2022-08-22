document.querySelector("#host").addEventListener('click', function(e) {
	e.preventDefault();
	RevealSeminar.open_or_join_room(document.getElementById('password').value);
});

document.querySelector("#close").addEventListener('click', function(e) {
	e.preventDefault();
	RevealSeminar.close_room(document.getElementById('password').value);
});