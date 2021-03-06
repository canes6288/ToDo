require 'spec_helper'

describe "tasks_pages" do

  subject { page }

  describe "show page GET /tasks/:id" do
    let(:my_task) { Task.create(title: "Do the dishes") }
    let(:my_task) { FactoryGirl.create(:task, title: "Do the dishes") }
    # Visit the show page /tasks/1 -- a single task
    before { visit task_path(my_task.id) }
    # Will see if the title is set correctly
    it { should have_title("Todo | Show Task") }
    # Will see if the headers are set correctly
    it { should have_selector('h1', text: 'Task Added') }
    it { should have_selector('p', text: my_task.title) }
  end

  describe "new page GET /tasks/new" do
    #Visit the new page
    before { visit new_task_path }
    #Test that it has the correct title and header
    it { should have_title("Todo | New Task") }
    it { should have_selector('h1', text: "New Task") }

    #Test the create action
    describe "create POST /tasks" do
      let(:submit) { "Save" }

        #Valid info
        #Fill in forms
        #Click submit --> Creates a new task, redirects to show page
      context "valid information" do
        before do
          visit new_task_path
          fill_in "Title",      with: "Walk the dog"
          check 'task_completed'
        end

        it "creates task" do
          expect { click_button submit }.to change(Task, :count).by(1)
        end

        describe "after submission" do
          before { click_button submit }
          #redirects to :show
          it { should have_title("Todo | Show Task") }
          it { should have_selector('p', text: "Walk the dog") }
        end
      end
        #Invalid info
        #Do not fill in forms
        #Click submit --> Does not create a new task, re-renders new page with error message
      context "invalid information" do
        it "does not create task" do
          expect { click_button submit }.not_to change(Task, :count)
        end

        describe "after submission" do
          before { click_button submit }
          # Re-renders :new with errors
          it { should have_title('Todo | New Task') }
          it { should have_content('error') }
        end
      end
    end
  end



  describe "index page GET /tasks" do
    before { visit tasks_path }

    let(:my_task) { Task.create(title: "Do the dishes") }

    it { should have_title('Todo | My Tasks') }
    it { should have_selector('h1', text: 'CheckList') }

    describe "destroy DELETE /tasks/:id" do
      it { should have_link('Delete', href: task_path(Task.first)) }

      it "destroys the task" do
        expect {
          click_link('Delete', match: :first)
        }.to change(Task, :count).by(-1)
      end
    end
  end

  describe "edit page GET /tasks/:id/edit" do
    let(:task) { Task.create(title: "Do the dishes") }

    before { visit edit_task_path(task.id) }

    it { should have_title('Todo | Edit Task') }
    it { should have_selector('h1', text: 'Edit Task')}

    describe "update PUT /tasks/:id" do
      let(:submit) { "Save" }

      context "valid information" do
        before do
          fill_in "Title", with: "Walk the dog"
          click_button submit
        end


        it { should have_title("Todo | Show Task") }
        it { should have_selector('p', text: "Walk the dog") }
        specify { expect(task.reload.title).to eq("Walk the dog") }
      end



      context "invalid information" do
        before do
          fill_in "Title", with: ""
          click_button submit
        end

        it { should have_title('Todo | Edit Task') }
        it { should have_content('error') }
      end
    end
  end
end

