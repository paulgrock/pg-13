// Generated by CoffeeScript 1.4.0
(function(){var e;e={Models:{},Views:{},Collections:{}};e.Models.Page=Backbone.Model.extend({defaults:{title:"paulgrock.com web developer",content:"Hi, I'm Paul Grock",identifier:"index"}});e.Views.Page=Backbone.View.extend({tagName:"section",template:_.template($("#page-template").html),initialize:function(){},render:function(){},addOne:function(e){}});e.Views.Pages=Backbone.View.extend({className:"main",initialize:function(){},render:function(){},addOne:function(e){}});e.Collections.Pages=Backbone.Collection.extend({model:e.Models.Page})}).call(this);