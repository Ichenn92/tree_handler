module TreeHandler
  module Comparable
    def compare(node_A, node_B)
      if node_B.value < node_A.value
        if node_A.left_child.nil?
          node_A.left_child = node_B
        else
          compare(node_A.left_child, node_B)
        end
      else
        if node_A.right_child.nil?
          node_A.right_child = node_B
        else
          compare(node_A.right_child, node_B)
        end
      end
    end
  end
end