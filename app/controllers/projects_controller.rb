class ProjectsController < ApplicationController
  include ProjectNotice

  before_action :set_project, :except => [:index, :new, :create]

  def index
    @projects = Project.active
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to project_path(@project),
                      :notice => ProjectNotice::CREATE_SUCCESS }
      else
        error_messages = ProjectNotice.format_error_messages(@project.errors)
        flash[:error] = error_messages
        format.html { render :action => 'new' }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(@project),
                      :notice => ProjectNotice::UPDATE_SUCCESS }
      else
        format.html { render :action => 'edit' }
      end
    end
  end

  def destroy
    @project.update_attribute(:active, false)
    respond_to do |format|
      format.html { redirect_to projects_path,
                    :notice => ProjectNotice::DESTROY_SUCCESS }
    end
  end

  def clear
    if @project.items.complete.destroy_all.empty?
      flash[:notice] = ProjectNotice::NO_ITEMS_TO_CLEAR 
    else
      flash[:notice] = ProjectNotice::ITEMS_CLEARED 
    end
    respond_to do |format|
      format.html { redirect_to project_path(@project) }
    end
  end

private
  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title)
  end
end

