class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!

  respond_to :html

  def index
    @tasks = Task.all
    respond_with(@tasks)
  end

  def show
    respond_with(@task)
  end

  def new
    @task = Task.new
    respond_with(@task)
  end

  def edit
  end

  def create
    pars = {
      title: params[:task][:title],
      description: params[:task][:description],
      group_id: params[:task][:group_id],
      completed: 0,
      current_user: current_user
    }
    @task = Task.new(pars)

    respond_to do |format|
      if @task.save
        session[:selected_task_id] = @task.id
        format.html { redirect_to root_url, notice: 'Task was successfully created.' }
        format.json { render json: @group, status: :created, location: @post }
      else
        format.html { redirect_to root_url }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    pars = {
      title: params[:task][:title],
      description: params[:task][:description],
      user_id: params[:task][:user_id],
      group_id: params[:task][:group_id],
      completed: params[:task][:completed],
      current_user: current_user,
      due_at: params[:task][:due_at]
    }
    @task = Task.find(params[:id])
    previous_user = @task.user_id
    respond_to do |format|
      if @task.update(pars)
        updated_user = @task.user_id
        if previous_user != updated_user && updated_user != nil
          FeedMailer.assigned(@task.user.email,@task.description,@task.id,@task.group_id,current_user).deliver
        end
        format.html { redirect_to root_url, notice: 'Task was successfully updated.' }
        format.json { render json: @task, status: :created, location: @post }
      else
        format.html { redirect_to root_url }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    respond_with(@task)
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :description, :completed, :group_id, :due_at)
    end
end
