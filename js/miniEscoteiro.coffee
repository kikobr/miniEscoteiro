source   = $("#entry-template").html()
template = Handlebars.compile source
context =
	name: 'kiko'

$("body").html template context

`urls = [
    {
		url: '/',
		name: 'index',
		template: '',
		context: {
			name: "x",
		}
	},
	{
		url: '/algo',
		name: 'algo',
		template: '',
		context: {
			name: "aee"
		}
	}
]`

`appModel = {
	name: 'index',
	element: '#div',
	template: '',
	context: {},
	children: [
		{
			name: 'algo1',
			element: '#div',
			template: '',
			context: {},
			children: [
				{
					name: 'algo2',
					element: '#div',
					template: '',
					context: {},
					children: [
						{
							name: 'algo3',
							element: '#div',
							template: '',
							context: {},
							children: [
								{
									name: 'algo4',
									element: '#div',
									template: '',
									context: {},
									children: []
								}
							]
						}
					]
				},
				{
					name: 'algo2-2',
					element: '#div',
					template: '',
					context: {},
					children: [
						{
							name: 'algo3',
							element: '#div',
							template: '',
							context: {},
							children: [
								{
									name: 'algo45',
									element: '#div',
									template: '',
									context: {},
									children: []
								}
							]
						}
					]
				},
				{
					name: 'algo2-3',
					element: '#div',
					template: '',
					context: {},
					children: []
				},
				{
					name: 'algo2-4',
					element: '#div',
					template: '',
					context: {},
					children: []
				}
			]
		},
	]
}
`




Object.size = (obj) ->
    size = 0
    for key of obj
    	size++ if obj.hasOwnProperty key
    return size




$.fn.miniEscoteiro = (params) ->
	@model = params
	@defaultRoute = @currentRoute = params.name || 'index'
	_this = @

	@born = ->
		console.log @getRoutePath('algo4')

	@render = ->
		''

	@getRoutePath = (name) ->
		routePath = ""
		buildingPath = ""
		breakLoop = false
		traverse = (obj) ->
			for propName, propValue of obj
				break if breakLoop
				# (DO STUFF)
				if propName == 'name'
					buildingPath += "#{propValue}/"
				if propValue == name # stop the world, i wanna get off
					routePath = buildingPath
					stopLoop = true
					break
				#----------------------------------------
				# Children is an array of routes.
				# Keep traversing them, too.
				if propName == "children"
					if propValue.length
						for i, child of propValue
							traverse child
							cleanPath()
		cleanPath = ->
			regex = /\/([^\/]+)\/$/
			buildingPath = buildingPath.replace regex, '/'
		traverse( @model )
		return routePath
	
	# =====================================================================
	@born()
	return @


window.yay = $.fn.miniEscoteiro( appModel )
#console.log a.currentRoute

