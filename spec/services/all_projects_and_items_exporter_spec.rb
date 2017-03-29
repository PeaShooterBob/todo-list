require "spec_helper"

describe AllProjectsAndItemsExporter do
  let(:action) { "Buy some knives" }
  let(:formatted_action) { "[x] #{action}" }
  let(:item) do
    instance_double(Item,
                    :action => action,
                    :done => true)
  end
  let(:items) { [item] }

  let(:title) { "Be a masterchef" }
  let(:project) do
    instance_double(Project,
                    :title => title,
                    :active_items => items)
  end
  let(:projects) { [project] }

  let(:output_stream) do
    instance_double(IO,
                    :<< => true,
                    :pos => 0,
                    :puts => nil,
                    :rewind => 0,
                    :close => nil)
  end

  let(:item_formatter) {class_double(ItemFormatter) }
  let(:params) do
    {:projects => projects,
     :output_stream => output_stream,
     :item_formatter => item_formatter }
  end
  let(:exporter) { AllProjectsAndItemsExporter.new(params) }

  describe '.new' do
    it 'instantiates' do
      expect(exporter).to be_a(AllProjectsAndItemsExporter)
    end
  end

  describe '#export' do
    it 'prints the project title' do
      expect(item_formatter).to receive(:format).with(item.action, item.done)
      expect(output_stream).to receive(:puts).with(title)
      exporter.export
    end

    it "prints the item's formatted action" do
      expect(item_formatter).to receive(:format).with(item.action, item.done) { formatted_action }
      expect(output_stream).to receive(:puts).with(formatted_action)
      exporter.export
    end
  end
end
