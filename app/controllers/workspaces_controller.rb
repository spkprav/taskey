class WorkspacesController < ApplicationController
  before_action :set_workspace, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @workspaces = Workspace.all
    respond_with(@workspaces)
  end

  def show
    respond_with(@workspace)
  end

  def new
    @workspace = Workspace.new
    respond_with(@workspace)
  end

  def edit
  end

  def create
    @workspace = Workspace.new(workspace_params)
    @workspace.save
    respond_with(@workspace)
  end

  def update
    @workspace.update(workspace_params)
    respond_with(@workspace)
  end

  def destroy
    @workspace.destroy
    respond_with(@workspace)
  end

  private
    def set_workspace
      @workspace = Workspace.find(params[:id])
    end

    def workspace_params
      params.require(:workspace).permit(:title)
    end
end
