# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
renewGameStatus = (status) ->
	if status == false
		$('#game_status').text('Ожидание игрока...')
	else
		location.reload()

gon.watch('game_status', interval: 1000, renewGameStatus)

checkPlayingStatus = (status) ->
	if status == true
		$('#playing_status').text('Соперник играет...')
	else
		location.reload()

gon.watch('playing_status', interval: 10000, checkPlayingStatus)

checkPlayingStatusRev = (status) ->
	if status == false
		$('#playing_status').text('Соперник играет...')
	else if status == true
		location.reload()

gon.watch('playing_status_rev', interval: 10000, checkPlayingStatusRev)