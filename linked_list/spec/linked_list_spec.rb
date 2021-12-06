#frozen_string_literal: true


require_relative '../linked_list'
require_relative '../node'


describe LinkedList do 
	subject(:linked_list) {LinkedList.new}
	let(:node) {Node.new(7)}
	let(:second_node) {Node.new(8)}

	describe '#append' do		

		context 'when appending to an empty list' do

			it 'sets itself as both tail and head' do
				linked_list.append(node)
				expect(linked_list.head).to be(node)
				expect(linked_list.tail).to be(node)
			end
		end

		context 'when appending to a populated list' do

			before do 
				linked_list.append(node)
			end

			it 'sets itself as tail and sets prev tail.next_node to itself' do
				linked_list.append(second_node)
				expect(linked_list.tail).to be(second_node)
				expect(linked_list.head.next_node).to be(second_node)
			end
		end
	end

	describe '#prepend' do

		context 'when prepending to an empty list' do
			
			it 'sets itself as both head and tail' do
				linked_list.prepend(node)
				expect(linked_list.head).to be(node)
				expect(linked_list.tail).to be(node)
			end
		end

		context 'when prepending to a poplulated list' do

			before do
				linked_list.prepend(node)
			end

			it 'it sets its next_next node to current head, and set itself as head ' do
				linked_list.prepend(second_node)
				expect(linked_list.head.next_node).to be(node)
				expect(linked_list.head).to be(second_node)
			end
		end
	end
end