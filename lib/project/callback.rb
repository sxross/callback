Callback = Struct.new(:called, :args) do
  def method_missing(name, *)
    name == :"#{called}?" || (name == called && block_given? && yield(*args))
  end
end
