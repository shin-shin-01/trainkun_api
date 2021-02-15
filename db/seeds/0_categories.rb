params = [
  {}
]

for param in params:
  category = Category.find_or_initialize_by(id: param[:id])
  category.update!(param)
end
