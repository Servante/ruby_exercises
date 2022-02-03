
require '../node.rb'

describe Node do

	describe '#update_node' do
		subject(:sample_node) {described_class.new(14)}

		context 'when given a node and update next_node request' do 
			xit 'updates the given node with the new next_node' do
				new_node = (Node.new(15))
				sample_node.update_next_node(nil)
			end
		end
	end
end



