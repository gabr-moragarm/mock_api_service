# frozen_string_literal: true

require 'spec_helper'
require_relative '../../lib/port'

class MyPort < Port
  def foo; end
  def bar; end
end

class CompleteAdapter
  def foo; end
  def bar; end
end

class IncompleteAdapter
  def foo; end
end

RSpec.describe Port do
  it 'returns implemented: true when all methods are present' do
    result = MyPort.methods_implemented_by(CompleteAdapter.new)
    expect(result[:implemented]).to be true
    expect(result[:missing_methods]).to be_empty
  end

  it 'returns implemented: false and missing methods when not all are present' do
    result = MyPort.methods_implemented_by(IncompleteAdapter.new)
    expect(result[:implemented]).to be false
    expect(result[:missing_methods]).to eq([:bar])
  end

  it 'raises NotImplementedError if called on Port directly' do
    expect { Port.methods_implemented_by(Object.new) }.to raise_error(NotImplementedError)
  end
end
