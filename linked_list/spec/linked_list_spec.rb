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

			it 'sets its next_next node to current head, and set itself as head ' do
				linked_list.prepend(second_node)
				expect(linked_list.head.next_node).to be(node)
				expect(linked_list.head).to be(second_node)
			end
		end
	end

	describe '#size' do

		context 'when size is called on the linked_list' do
			subject(:list_size) {described_class.new}

			before do
				n1 = Node.new("7")
				n2 = Node.new("8")
				n3 = Node.new("9")
				list_size.append(n1)
				list_size.append(n2)
				list_size.append(n3)
			end

			it 'returns a count of all the nodes in the list' do
				count = list_size.size
				expect(count).to eq(3)
			end
		end
	end

	describe '#head and #tail' do
		subject(:getters_list) {described_class.new}

		before do 
			n1 = Node.new("A")
			n2 = Node.new("B")
			getters_list.append(n1)
			getters_list.append(n2)
		end

		context 'when the head method is called' do
			it 'returns the head of the list' do
				head = getters_list.head
				expect(head).to be(getters_list.head)
			end

			context 'when the tail method is called' do
				it 'returns the tail of the list' do
					tail = getters_list.tail
					expect(tail).to be(getters_list.tail)
				end
			end
		end
	end

	describe '#at' do

		subject(:traversal_list) {described_class.new} 

		before do 
			n1 = Node.new("7")
			n2 = Node.new("8")
			traversal_list.append(n1)
			traversal_list.append(n2)
		end

		context 'when given a valid index of 1' do

			it 'returns the value of node at index 1("8")' do
				returned_value = traversal_list.at(1)
				expect(returned_value.value).to be("8")
			end
		end
	end

	describe '#pop' do

		context 'when pop is used on a populated list' do
			it 'assigns the node before the tail as the tail' do
				linked_list.append(node)
			  linked_list.append(second_node)
				modified_list = linked_list.pop
				expect(modified_list.tail).to be(node)
			end
		end

		context 'when pop is used on an empty list' do
			it 'returns a message stating the list is empty' do
				message = "The list is empty."
				# binding.pry
				expect(linked_list).to receive(:puts).with(message)
				linked_list.pop
			end
		end

		context 'when pop is called on a list with only one node' do
			it 'it assigns both head and tail as nil' do
				linked_list.append(node)
				# binding.pry
				mod_list = linked_list.pop
				expect(mod_list.size).to be_nil
			end
		end
	end

	describe '#contains?' do

		before do 
			linked_list.append(node)
			linked_list.append(second_node)
		end

		context 'when given an argument that exists in the list' do
			it 'returns true' do
				query = 7
				returned_value = linked_list.contains?(query)
				expect(returned_value).to be(true)
			end
		end

		context 'when given an argument that does not exist in the list' do
			it 'returns false' do
				query = 100
				returned_value = linked_list.contains?(query)
				expect(returned_value).to_not be(true)
			end
		end
	end

	describe '#find' do 

		before do
			linked_list.append(node)
			linked_list.append(second_node)
		end

		context 'when given an argument that exists in the list' do
			it 'returns the index of the node that contains the value' do
				query = 8
				returned_index = linked_list.find(query)
				expect(returned_index).to eq(1)
			end
		end

		context 'when given an argument that does not exist in the list' do
			it 'returns nil' do
				query = 75
				returned_index = linked_list.find(query)
				expect(returned_index).to be_nil
			end
		end
	end
end