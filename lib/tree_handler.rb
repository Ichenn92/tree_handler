module TreeHandler
  require 'tree_handler/node'

  class Tree
    attr_accessor :data, :root
    include Comparable

    def initialize(array)
      @data = array.uniq
      @root = build_tree
    end

    def build_tree(array = @data.dup)
      root = Node.new(array.shift)
      array.each do |value|
        node = Node.new(value)
        compare(root, node)
      end
      root
    end

    def insert(value)
      unless @data.include? value
        @data.push(value)
        node = Node.new(value)
        compare(root, node)
      else
        raise "The same value can't be inserted twice"
      end
    end

    def delete(value, parent_pointer = @root)
      @data.delete(value)
      node = find(value)
      return nil if node.nil?

      unless node == @root
        parent = find_parent(value)
        parent_pointer =
          value < parent.value ? parent.left_child : parent.right_child
      end

      if node.left_child.nil?
        return parent_pointer = node.right_child
      elsif node.right_child.nil?
        return parent_pointer = node.left_child
      else
        parent_pointer = node.left_child
        compare(parent_pointer, node.right_child)
      end
    end

    def find(value, node = @root)
      if value == node.value
        return node
      elsif value < node.value
        return nil if node.left_child.nil?
        find(value, node.left_child)
      elsif value > node.value
        return nil if node.right_child.nil?
        find(value, node.right_child)
      end
    end

    def find_parent(value)
      value == @root.value ? nil : find_parent_rec(value)
    end

    def find_parent_rec(value, node = @root)
      value_left_child = node.left_child.nil? ? nil : node.left_child.value
      value_right_child = node.right_child.nil? ? nil : node.right_child.value

      if value == value_left_child || value == value_right_child
        return node
      elsif value < node.value
        value_left_child.nil? ? nil : find_parent_rec(value, node.left_child)
      elsif value > node.value
        value_right_child.nil? ? nil : find_parent_rec(value, node.right_child)
      end
    end

    def level_order(queue = [@root], no_block = [])
      until queue.empty?
        if block_given?
          yield(queue.map(&:value))
        else
          no_block.push(queue.map(&:value))
        end
        (0...queue.count).each do
          next_node = queue.shift
          queue.push(next_node.left_child) unless next_node.left_child.nil?
          queue.push(next_node.right_child) unless next_node.right_child.nil?
        end
      end
      no_block
    end

    def level_order_rec(queue = [@root], no_block = [], &block)
      queue_child = []
      if block_given?
        block.call(queue.map(&:value))
      else
        no_block.push(queue.map(&:value))
      end

      queue.each do |node|
        queue_child.push(node.left_child) unless node.left_child.nil?
        queue_child.push(node.right_child) unless node.right_child.nil?
      end
      level_order_rec(queue_child, no_block, &block) unless queue_child.empty?
      no_block
    end

    %i[preorder inorder postorder].each do |method|
      define_method(method) do |node = @root, no_block = [], &block|
        parent =
          Proc.new { block ? block.call(node.value) : no_block << node.value }

        parent.call if method == :preorder
        unless node.left_child.nil?
          send(method, node.left_child, no_block, &block)
        end
        parent.call if method == :inorder
        unless node.right_child.nil?
          send(method, node.right_child, no_block, &block)
        end
        parent.call if method == :postorder
        no_block
      end
    end

    def depth(node)
      node.nil? ? 0 : level_order([node]).size
    end

    def balanced?(root = @root)
      left_height = depth(root.left_child)
      right_height = depth(root.right_child)
      (-1..1).include?(left_height - right_height)
    end

    def rebalance!
      result = rebalance_ordering(@data.dup.sort)
      @root = build_tree(result)
    end

    def rebalance_ordering(tree, result = [])
      return if tree.size == 0
      middle = tree.size / 2
      result.push tree.slice!(middle)
      rebalance_ordering(tree[0...middle], result)
      rebalance_ordering(tree[(middle)..-1], result)
      result
    end
  end
end
