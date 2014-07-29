source   = $("#entry-template").html()
template = Handlebars.compile source
context =
	name: 'kiko'

$("body").html template context

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
}`

$.fn.miniEscoteiro = (params) ->
	@model = params
	@defaultRoute = @currentRoute = params.name || 'index'

	@born = ->
		console.log @getRoute('index/algo1/algo2-3')
		@getRoute('index/algo1/algo2-2/algo3/')

	@getRoutePath = (name) ->
		routePath = ""
		buildingPath = ""
		@traverse @model, (propName, propValue) ->
				if propName == 'name'
					buildingPath += "#{propValue}/"
				if propValue == name # stop the world, i wanna get off
					routePath = buildingPath
					buildingPath = ""
					return false
			, () ->
				# index/path1/path1-1/ -> index/path1/
				regex = /\/([^\/]+)\/$/
				buildingPath = buildingPath.replace regex, '/'
		return routePath



	# Returns an object for the route.
	# It is reached following the names in the path

	@getRoute = (path) ->
		path = path.replace(/\/$/, '').replace(/^\//, '') # clean '/' on beginning and endings
		stepsArray = path.split '/'
		currentStep = 0
		route = {}
		newChild = false
		@traverse @model, (propName, propValue, obj) ->
				if propName == 'name' 
					# check if current propValue is present on the stepsArray in the
					# right position, in order to make sure we will find the right route.
					if propValue == stepsArray[currentStep]
						currentStep += 1
						if currentStep == stepsArray.length
							route = obj
							return false # stopping everything
					else if newChild
						currentStep -= 1
						newChild = false
			, () ->
				newChild = true
		return route


	
	# Loops through all the model object properties,
	# making it available to check each property value
	# at each iteration time. 
	
	@traverse = (obj, fn, fn2) ->
		nextBranch = ->
			if fn2? then fn2()
		for propName, propValue of obj
			# (DOING STUFF)
			break if fn(propName, propValue, obj) == false
			# ----------------------------------------
			# Children is an array of routes.
			# Keep traversing them, too.
			if propName == "children"
				if propValue.length
					for i, child of propValue
						@traverse child, fn, fn2
						nextBranch()
		''

	# =====================================================================
	@born()
	return @


window.yay = $.fn.miniEscoteiro( appModel )
#console.log a.currentRoute

