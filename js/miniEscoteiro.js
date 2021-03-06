// Generated by CoffeeScript 1.4.0
(function() {
  var context, source, template;

  source = $("#entry-template").html();

  template = Handlebars.compile(source);

  context = {
    name: 'kiko'
  };

  $("body").html(template(context));

  appModel = {
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
};


  $.fn.miniEscoteiro = function(params) {
    this.model = params;
    this.defaultRoute = this.currentRoute = params.name || 'index';
    this.born = function() {
      console.log(this.getRoute('index/algo1/algo2-3'));
      return this.getRoute('index/algo1/algo2-2/algo3/');
    };
    this.getRoutePath = function(name) {
      var buildingPath, routePath;
      routePath = "";
      buildingPath = "";
      this.traverse(this.model, function(propName, propValue) {
        if (propName === 'name') {
          buildingPath += "" + propValue + "/";
        }
        if (propValue === name) {
          routePath = buildingPath;
          buildingPath = "";
          return false;
        }
      }, function() {
        var regex;
        regex = /\/([^\/]+)\/$/;
        return buildingPath = buildingPath.replace(regex, '/');
      });
      return routePath;
    };
    this.getRoute = function(path) {
      var currentStep, newChild, route, stepsArray;
      path = path.replace(/\/$/, '').replace(/^\//, '');
      stepsArray = path.split('/');
      currentStep = 0;
      route = {};
      newChild = false;
      this.traverse(this.model, function(propName, propValue, obj) {
        if (propName === 'name') {
          if (propValue === stepsArray[currentStep]) {
            currentStep += 1;
            if (currentStep === stepsArray.length) {
              route = obj;
              return false;
            }
          } else if (newChild) {
            currentStep -= 1;
            return newChild = false;
          }
        }
      }, function() {
        return newChild = true;
      });
      return route;
    };
    this.traverse = function(obj, fn, fn2) {
      var child, i, nextBranch, propName, propValue;
      nextBranch = function() {
        if (fn2 != null) {
          return fn2();
        }
      };
      for (propName in obj) {
        propValue = obj[propName];
        if (fn(propName, propValue, obj) === false) {
          break;
        }
        if (propName === "children") {
          if (propValue.length) {
            for (i in propValue) {
              child = propValue[i];
              this.traverse(child, fn, fn2);
              nextBranch();
            }
          }
        }
      }
      return '';
    };
    this.born();
    return this;
  };

  window.yay = $.fn.miniEscoteiro(appModel);

}).call(this);
