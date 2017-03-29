namespace :todo do
  namespace :checklists do
    desc "Prints a checklist of projects and their items" 
    task :export => :environment do
      AllProjectsAndItemsExporter.new.export
    end
  end
end
