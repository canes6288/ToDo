# 1. Create a GET tasks#show page when the user visits /tasks/:id (aka visits /tasks/3)

require 'spec_helper'

describe TasksController, type: :controller do
  # before { @task = Task.create(title: "Walk the dog") }
  before { @task = FactoryGirl.create(:task) }

  describe "GET show" do
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
    it "renders new page" do
      get :new
      expect(response).to render_template(:new)
    end

    it "assigns new Task to @task" do
      get :new
      assigns(:task).should be_a_new(Task) #confirm that @task = Task.new
    end
  end


  describe "GET edit" do
    let(:task) { Task.create(title: "Walk the dog") }
      #Current Task: Walk the Dog
      #New Task : ...
    it "renders :edit" do
      get :edit, id: task.id
      expect(response).to render_template(:edit)
    end

    it "assigns requested task to @task" do
      get :edit, id: task.id
      assigns(:task).should eq(task)
    end
  end

  describe "GET index" do
    before { Task.destroy_all }

    let(:first_task) { Task.create(title: "Walk the dog") }
    let(:second_task) { Task.create(title: "Buy Groceries") }
      # It should assign @tasks equal to all Tasks aka @tasks = Task.all
      # End goal is to have it be like:
      # @tasks == [{ id: 1, title: "Walk the dog"}, {id: 2, title "Groceries"...]
    it "renders :index" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assign array of all tasks to @tasks" do
      get :index
      assigns(:tasks).should eq([first_task, second_task])
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      # adds new Task to the tasks database
      # When I post to the create action, change Task.count by 1, aka add 1 to the tasks db
      it "create task in database" do
        expect{
          post :create, task: { title: "Walk the dog" }
          }.to change(Task, :count).by(1)
      end

      it "redirects to show page" do
        post :create, task: { title: "Walk the dog" }
        last_task = Task.last
        expect(response).to redirect_to(task_path(last_task.id))
      end
    end

    context "with invalid attributes" do
      it "does not save task to database" do
        expect{
          post :create, task: { title: "" }
          }.to_not change(Task, :count)
      end

      it "re-renders new page" do
        post :create, task: { title: "" }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT update" do
    let(:task) { Task.create(title: "Do the dishes") }

    context "with valid attributes" do
      it "changes @task's attributes" do
        # 1. Make a change to @task in the background
        put :update, id: task.id, task: { title: "Walk the dog" }
        # 2. Refresh Data
        task.reload
        #3. Test that @task (older version) isn't the same as @task (edited version)
        expect(task.title).to eq("Walk the dog")
      end

      it "redirects to :show" do
        put :update, id: task.id, task: { title: "Walk the dog" }
        last_task = Task.last
        expect(response).to redirect_to(task_path(last_task.id))
      end
    end

    context "with invalid attributes" do
      it "does not change @task's attributes" do
        put :update, id: task.id, task: { title: "" }
        task.reload
        expect(task.title).to eq("Do the dishes")
      end

      it "re-renders :edit" do
        put :update, id: task.id, task: { title: "" }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE destroy" do
    let!(:task) { Task.create(title: "Walk the dog") }

    it "deletes requested task" do
      expect{
        delete :destroy, id: task.id
      }.to change(Task, :count).by(-1)
    end

    it "re-directs to :index" do
      delete :destroy, id: task.id
      expect(response).to redirect_to(tasks_path)
    end
  end
end
