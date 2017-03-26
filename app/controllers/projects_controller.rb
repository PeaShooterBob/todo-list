class ProjectsController < ApplicationController
  include ProjectNotice

  before_action :set_project, :except => [:index, :new, :create]

  def index
    @projects = Project.active
  end

  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.active?
        format.html { render :action => 'show' }
      else
        flash[:error] = ProjectNotice::INACTIVE_PROJECT
        format.html { redirect_to projects_path }
      end
    end
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
    cleared_items_count = @project.items.complete.update_all(:active => false)
    if cleared_items_count > 0
      flash[:notice] = ProjectNotice::ITEMS_CLEARED 
    else
      flash[:error] = ProjectNotice::NO_ITEMS_TO_CLEAR 
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

