# TreeHandler
TreeHandler is a ruby library allowing yourself to discover **binary trees**.
Build your own data structure and search trough your model with Tree Traversals (in-order, pre-order, post-order and level-order)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tree_handler'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install tree_handler

## Usage

Be aware that this library works only without duplicate value.

### Modification methods

start by creating a new tree

```ruby
my_object = TreeHandler.new(array)
# @params : an array of integer (duplicate value won't raise error, they are automatically removed)
# return : the full object with each node
```


You can then modify by inserting or deleting some nodes by value

```ruby
my_object.insert(value)
# @params : an integer (an existing value will raise an error)
# return : The created node or RuntimeError (The same value can't be inserted twice) if value exists already
```
```ruby
my_object.delete(value, parent_pointer = @root)
# @params1 : an integer
# @params2 : the node where the search will start. Default value : root of the tree
# return : The deleted node or nil of value not found
```
To check if the tree is balanced (same depth on each child of the root), simply :

```ruby
my_object.balanced?
# return : true if balanced
```

To rebalance the tree, type :

```ruby
my_object.rebalance!
# return : the full object with each node
```
### Navigation methods

[Tree traversal](https://en.wikipedia.org/wiki/Tree_traversal#Breadth-first_search_/_level_order) is a way to visit each node in your tree.

```ruby
# preorder search
	my_object.preorder
	# return an array of integer

# inorder search
	my_object.inorder
	# return an array of integer
	
# postorder search
	my_object.postorder
	# return an array of integer

# breadth-first search / level order
	my_object.level_order
	# return an array of array for each level
```

Other useful  method

```ruby
# find node for a certain value
	my_object.find(integer, start_node = @root)
	# @params1 : integer, the value of the node desired
	# @params2 : the node where the search will start. Default value : root of the tree
	# return the node or nil if not found

# find parent a certain value
	my_object.find_parent(integer)
	# @params1 : integer
	# return the parent's node of the value searched or nil if not found
# know the depth of your tree
	my_object.depth(start_node)
	# @params1 : the node where the search will start. 
	# return an integer of the tree's height
```




## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/tree_handler.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

