class Array
  def bucketize(count)
    raise ArgumentError unless count.kind_of? Fixnum

    count = count.to_i

    return self if count <= 0

    j = length / count.to_f
    result = each_with_index.chunk { |_, i| (i / j).floor }.map { |_, v| v.map(&:first) }
    result << [] until result.length == count
    result
  end
end