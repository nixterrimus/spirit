module Device::Abilities::Dimmable
  def level
    @level || default_level
  end

  def level=(new_level)
    raise unless valid_level?(new_level)
    @level = new_level
  end

  def dim_up(amount=10)
    self.level = [self.level + amount, max_level].min
    self.apply_state
  end

  def dim_down(amount=10)
    self.level = [self.level - amount, min_level].max
    self.apply_state
  end

  def default_level
    0
  end

  def max_level
    100
  end

  def min_level
    0
  end

  def valid_level?(level)
    level.between?(min_level, max_level)
  end
end
