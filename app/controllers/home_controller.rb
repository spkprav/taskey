class HomeController < ApplicationController

  before_action :authenticate_user!

  def index
    @group = Group.new
    @task = Task.new
    @feed = Feed.new
    @uncategorized = Task.where(group_id: nil).count
    @groups = Group.includes(:tasks).all
    @my_tasks = Task.where(user_id: current_user.id).count

    if params[:task] == 'mytask'
      @tasks = Task.includes(:user).where(user_id: current_user.id)
    else
      if session[:selected_group_id] == nil
        @tasks = Task.includes(:user).where(user_id: current_user.id)
      else
        if session[:selected_group_id] != 'nil'
          @group_update = Group.find(session[:selected_group_id])
          @tasks = Task.includes(:user).where(group_id: session[:selected_group_id])
        else
          @group_update = nil
          @tasks = Task.includes(:user).where(group_id: 0)
        end
      end
    end

    if session[:selected_task_id] == nil
      @selected_task = Task.new
    else
      @selected_task = Task.includes(:feeds,feeds:[:user]).find(session[:selected_task_id])
    end

  end

  def new_index
    session[:return_to] = request.fullpath
    @new_group = Group.new
    @new_task = Task.new

    if params[:workspace_id].nil?
      @custom_workspace = true
      params[:workspace_id] = "1"
    end
    @workspace_groups = Group.where(workspace_id: params[:workspace_id]).all

    if params[:user_id].nil?
      @group_tasks = Task.joins(:group).where('tasks.user_id = ? AND tasks.completed = ?',current_user.id,false)
    elsif params[:user_id] != nil && params[:workspace_id].nil? && params[:group_id].nil? && params[:task_id].nil? && @custom_workspace == true
      @group_tasks = Task.joins(:group).where('tasks.user_id = ? AND tasks.completed = ?',current_user.id,false)
    elsif params[:user_id] != nil && params[:workspace_id] != nil && params[:group_id].nil? && params[:task_id].nil?
      @group_tasks = Task.joins(:group).includes(:group).where('groups.workspace_id = ? AND tasks.completed = ?',params[:workspace_id],false).where('tasks.user_id = ?',current_user.id)
    elsif params[:user_id] != nil && params[:workspace_id] != nil && params[:group_id] != nil && params[:task_id].nil?
      @group_tasks = Task.joins(:group).includes(:group).where('groups.workspace_id = ? AND groups.id = ? AND tasks.completed = ?',params[:workspace_id], params[:group_id],false)
    elsif params[:user_id] != nil && params[:workspace_id] != nil && params[:group_id] != nil && params[:task_id] != nil
      @group_tasks = Task.joins(:group).includes(:group,:feeds).where('groups.workspace_id = ? AND groups.id = ? AND tasks.completed = ?',params[:workspace_id], params[:group_id],false)
      @selected_task = Task.includes(:feeds).find(params[:task_id])
      @new_feed = Feed.new
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

  def from_mail
    session[:selected_task_id] = params[:task_id]
    session[:selected_group_id] = params[:group_id]
    redirect_to root_path
  end

end
