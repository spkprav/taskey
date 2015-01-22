class HomeController < ApplicationController

  before_action :authenticate_user!

  def index
    @group = Group.new
    @task = Task.new
    @feed = Feed.new
    @groups = Group.all

    if params[:task] == 'mytask'
      @tasks = Task.includes(:feeds).where(user_id: current_user.id)
    else
      if session[:selected_group_id] == nil
        @tasks = Task.all
      else
        @tasks = Task.where(group_id: session[:selected_group_id])
      end
    end

    if session[:selected_task_id] == nil
      @selected_task = Task.new
    else
      @selected_task = Task.includes(:feeds).find(session[:selected_task_id])
    end
    
  end

  def selected_group
    if session[:selected_group_id] == nil
      session[:selected_group_id] ||= params[:group_id]
    else
      session[:selected_group_id] = params[:group_id]
    end
    redirect_to root_path
  end

  def selected_task
    if session[:selected_task_id] == nil
      session[:selected_task_id] ||= params[:task_id]
    else
      session[:selected_task_id] = params[:task_id]
    end
    redirect_to root_path
  end

end
