$(document).ready ->
  #setup backbone model
  class window.Task extends Backbone.Model
    initialize: ->
      if(!@get('title'))
        @set('title')
  #setup backbone collection
  class window.Tasks extends Backbone.Collection
    url: '/tasks'
    model: Task

  window.tasks = new Tasks
  #setup backbone views
  class window.TaskView extends Backbone.View
    tagName: 'li'
    events:
      "click .task": "displayTitle"
      
    template: _.template($("#task_view").html())
    render: =>
      $(@el).append(@template(@model.toJSON()))
      this

    displayTitle: =>
      alert(@model.get('title'))
      false
  
  class window.ManageTasksView extends Backbone.View
    el: $("#manage_tasks")
    events:
      "click #create_task_button": "createTask"
    initialize: ->
      tasks.bind('add',@addTask)
      tasks.bind('all',@addAllTasks)
      tasks.fetch()
    createTask: =>
      window.tasks.create {title: @$("#task_title").val()}
    addTask: (task)=>
      console.log(task)
      tv = new TaskView {model: task}
      @$("#tasks").append(tv.render().el)
    addAllTasks: =>
      console.log("I have got called")
      @$("#tasks").html("")
      tasks.map(@addTask)

  window.app = new ManageTasksView
