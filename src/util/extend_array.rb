class Array

  # Returns true if other has exactly the same elements as the current array.
  # Order of the elements does not matter.
  def same?(other)
    (self.sort! <=> other.sort!) == 0
  end

  # Returns true if self and other have any elements in common
  def overlap?(other)
    (self - other).size < self.size
  end

  def mean
    sum / size
  end

  def random_element
    # (MJM) using Kernel.rand because was getting weird bug w/o it -
    # seemed like it was calling a different rand that required 0 args.
    return self[Kernel.rand(self.length)]
  end

end