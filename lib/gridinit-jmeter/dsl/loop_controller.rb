module Gridinit
  module Jmeter

    class DSL
      def loop_controller(params={}, &block)
        node = Gridinit::Jmeter::LoopController.new(params)
        attach_node(node, &block)
      end
    end

    class LoopController
      attr_accessor :doc
      include Helper

      def initialize(params={})
        params[:name] ||= 'LoopController'
        @doc = Nokogiri::XML(<<-EOS.strip_heredoc)
<LoopController guiclass="LoopControlPanel" testclass="LoopController" testname="#{params[:name]}" enabled="true">
  <boolProp name="LoopController.continue_forever">true</boolProp>
  <stringProp name="LoopController.loops">1</stringProp>
</LoopController>)
        EOS
        update params
        update_at_xpath params if params[:update_at_xpath]
      end
    end

  end
end
