# 1. Create a GET tasks#show page when the user visits /tasks/:id (aka visits /tasks/3)

require 'spec_helper'

describe TasksController, type: :controller do
  describe "GET show" do
    before { @task = Task.create(title: "Walk the dog") }

    it "assigns requested task to @task" do
      get :show, id: @task.id
      #Expect @task to be set to the task we're looking for
      assigns(:task).should eq(@task)
    end

    it "renders show page" do
      get :show, id: @task.id
      expect(response).to render_template(:show)
    end
    # @task = Task.find(params[:id])
    # When we go to /tasks/3
    # Right side of equal sign --> Task.find(3) --> { id: 3, title: "Walk the dog", created_at: }
  end

  describe "GET new" do
    it "renders new page"
  end


  describe "GET edit" do
  #Current Task: Walk the Dog
  #New Task : ...
    it "finds requested task to edit"
    it "renders edit page"
  end

  describe "GET index" do
    it "assign all tasks to @tasks"
    it "renders index page"
  end

  describe "POST create" do
    context "with valid attributes"
      it "saves task to database"
      it "redirects to index page"

    context "with invalid attributes"
      it "does not save task to database"
      it "redirects to index page"
  end

  describe "PUT update ToDo tasks on index list" do
    context "with valid attributes" do
      it "finds current task in database"
      it "assigns updated task to current task"
      it "redirects to index ToDo list page"
    end

    context "with invalid attributes" do
      it "does not reassign current task in database"
      it "redirects to index page"
    end
  end

  describe "DELETE task on ToDo index list" do
    it "finds current task in database"
    it "removes current task from database"
  end
end
