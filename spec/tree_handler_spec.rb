RSpec.describe TreeHandler::Tree do
  it "has a version number" do
    expect(TreeHandler::VERSION).not_to be nil
  end

  it "return the preordered list" do
    tree = TreeHandler::Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
    expect(tree.preorder).to eq [1, 7, 4, 3, 5, 23, 8, 9, 67, 6345, 324]
  end
end
