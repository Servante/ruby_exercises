#frozen_string_literal: true


require_relative '../linked_list'
require_relative '../node'


describe LinkedList do 

	describe '#append' do
		subject(:list) {described_class.new}
		let(:append_node) {Node.new(7)}

		before do
			list.append(:append_node)
		end

		context 'when you append a node' do
			it 'attaches the node to the head' do
				# node = Node.new(7)
				expect(list.head).to be(:append_node)
			end

			it 'and it sets the new node to the tail' do
				expect(list.tail).to be(:append_node)
			end
		end
	end
end