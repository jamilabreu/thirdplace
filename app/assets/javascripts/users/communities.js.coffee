jQuery ->
	$("select").selectize
		create: (input) ->
			return { value: input, text: input }