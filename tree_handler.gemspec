require_relative 'lib/tree_handler/version'

Gem::Specification.new do |spec|
  spec.name          = "tree_handler"
  spec.version       = TreeHandler::VERSION
  spec.authors       = ["Tristan Hörler"]
  spec.email         = ["tristan.horler@gmail.com"]

  spec.summary       = "Handling Search BinaryTree with ease"
  spec.description   = "Set of functions to create, modify and search in a binary tree from a list." 
  spec.homepage      = "https://github.com/Ichenn92/tree_handler"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
