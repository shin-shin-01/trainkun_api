params = [
  {
    id: 1,
    name: '場所'
  },
  {
    id: 2,
    name: '服'
  }
]

for param in params do
  category = Category.find_or_initialize_by(id: param[:id])
  category.update!(param)
end
