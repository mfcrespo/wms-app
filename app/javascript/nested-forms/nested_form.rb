# Copyright (c) 2021 Maria Crespo
# Don't count the days, make the days count...Go Head!
# All Rights Reserved

$(document).on('turbolinks:load', function() {

		$('form').on('click', '.remove_record', function(event) {
				console.log('clicked remove!')
				$(this).prev('input[type=hidden]').val('1');
				$(this).closest('tr').hide();
				return event.preventDefault();
		});

		$('form').on('click', '.add_fields', function(event) {
				console.log('clicked add!')
				let regexp, time;
				time = new Date().getTime();
				regexp = new RegExp($(this).data('id'), 'g');
				$('.fields').before($(this).data('fields').replace(regexp, time));
				return event.preventDefault();
		});
});
