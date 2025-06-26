defimpl Jason.Encoder, for: Decimal do
  def encode(value, opts) do
    Jason.Encode.string(Decimal.to_string(value), opts)
  end
end
