class ItemsController < ApplicationController
  include ItemNotice
  include ErrorFormatter
  before_filter :get_project

  def new
    @item = @project.items.build
  end

  def create
    @item = @project.items.build(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to project_path(@project),
                      :notice => ItemNotice::CREATE_SUCCESS }
      else
        flash[:error] = ErrorFormatter.format(@item.errors)
        format.html { render :action => 'new' }
      end
    end
  end

  def edit
    @item = @project.items.find(params[:id])
  end

  def update
    @item = @project.items.find(params[:id])

    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to project_path(@project),
                      :notice => ItemNotice::UPDATE_SUCCESS }
      else
        flash[:error] = ErrorFormatter.format(@item.errors)
        format.html { render :action => 'edit' }
      end
    end
  end

private

  def get_project
    @project = Project.find(params[:project_id])
  end

  def item_params
    params.require(:item).permit(:action, :done)
  end
end

