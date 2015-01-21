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
      user_id: current_user.id,
      group_id: params[:task][:group_id],
      completed: 0
    }
    @task = Task.new(pars)

    respond_to do |format|
      if @task.save
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
      user_id: current_user.id,
      group_id: params[:task][:group_id],
      completed: params[:task][:completed]
    }
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update(pars)
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
      params.require(:task).permit(:title, :description, :completed, :group_id)
    end
end
