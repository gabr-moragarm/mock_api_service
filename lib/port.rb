# frozen_string_literal: true

# Port defines an instance of a contract that an adapter must implement.
# The Port class serves as an abstract interface for adapters, providing a mechanism to verify
# that a given adapter implements all required instance methods defined by a subclass of Port.
#
# @abstract
# @example
#   class MyPort < Port
#     def foo; end
#   end
#
#   adapter = MyAdapter.new
#   MyPort.methods_implemented_by(adapter)
#   # => { implemented: true, missing_methods: [] }
#
#   adapter = IncompleteAdapter.new
#   MyPort.methods_implemented_by(adapter)
#   # => { implemented: false, missing_methods: [:foo] }
#
# @see Port.methods_implemented_by
class Port
  # Checks if the given adapter implements all required methods.
  #
  # @param adapter [Object] The adapter instance to check.
  # @return [Hash] Returns a hash with :implemented (Boolean) and :missing_methods (Array of Symbols).
  #
  # @example
  #   result = Port.methods_implemented_by(adapter)
  #   if result[:implemented]
  #     puts "All methods implemented!"
  #   else
  #     puts "Missing: #{result[:missing_methods].join(', ')}"
  #   end
  #
  # @note This method checks only the methods defined in the Port class itself, not in its ancestors.
  #
  # @see Module#instance_methods
  #
  # @api public
  def self.methods_implemented_by(adapter)
    raise(NotImplementedError, 'This must be called on a subclass of Port, not on Port itself.') if self == Port

    required_methods = instance_methods(false)
    missing = required_methods.reject { |m| adapter.respond_to?(m) }

    {
      implemented: missing.empty?,
      missing_methods: missing
    }
  end
end
