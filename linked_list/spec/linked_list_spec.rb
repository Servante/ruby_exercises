#frozen_string_literal: true


require_relative '../linked_list'
require_relative '../node'


describe LinkedList do 


	describe '#empty_list' do
		subject(:list) {described_class.new}
		let(:empty_list_node) {Node.new(7)}

		context 'when you append a node to an empty list' do

			before do 
				list.append(:empty_list_node)
			end

			it 'attaches the node to the head' do
				expect(list.head).to be(:empty_list_node)
			end

			it 'and attaches itself to the tail' do
				expect(list.tail).to be(:empty_list_node)
			end
		end

		context 'when you prepend a node to an empty list' do

			before do 
				list.prepend(:empty_list_node)
			end

			it 'attaches the node to the head' do
				expect(list.head).to be(:empty_list_node)
			end

			it 'and sets itself to the tail' do
				expect(list.tail).to be(:empty_list_node)
			end
		end
	end








	# describe '#append' do
	# 	subject(:list) {described_class.new}		
	# 	let(:append_node) {Node.new(7)}

	# 	before do
	# 		list.append(:append_node)
	# 	end

	# 	context 'when you append a node to an empty list' do
	# 		xit 'attaches the node to the head' do
	# 			expect(list.head).to be(:append_node)
	# 		end

	# 		xit 'and it sets the new node to the tail' do
	# 			expect(list.tail).to be(:append_node)
	# 		end
	# 	end

		#need 2 tests for when it attaches to the tail




	# end

	# describe '#prepend' do
	# 	subject(:list) {described_class.new}
	# 	let(:prepend_node) {Node.new(7)}

	# 	context 'When you prepend a node to an empty list' do			
	# 		before do 
	# 			list.prepend(:prepend_node)
	# 		end

	# 		xit 'attaches the node to the head' do
	# 			expect(list.head).to be(:prepend_node)
	# 		end

	# 		xit 'and it sets the node to the tail' do
	# 			expect(list.tail).to be(:prepend_node)
	# 		end
	# 	end

	# 	context 'when prepending to an existing list' do

	# 	end


		



	# end







end