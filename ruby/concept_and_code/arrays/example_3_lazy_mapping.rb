p (1..)
  .lazy
  .map { |n| n * n }
  .select(&:even?)
  .first(3)
# => [4, 16, 36]
# Useful for large or infinite collections.
# Without lazy, an infinite range would never finish.
