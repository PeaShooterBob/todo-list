class AllProjectsAndItemsExporter
  def initialize(projects: Project.all, output_stream: $stdout, item_formatter: ItemFormatter)
    @projects = projects
    @output_stream = output_stream
    @item_formatter = item_formatter
  end

  def export
    @projects.each do |project|
      @output_stream.puts(project.title)
      project.active_items.each do |item|
        @output_stream.puts(@item_formatter.format(item.action, item.done))
      end
    end
  end
end
