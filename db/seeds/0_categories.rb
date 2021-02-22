params = [
  {
    id: 1,
    name: 'place'
  },
  {
    id: 2,
    name: 'fashion'
  },
  {
    id: 3,
    name: 'food'
  },
  {
    id: 4,
    name: 'machine'
  },
  {
    id: 5,
    name: 'music'
  }
]

for param in params do
  category = Category.find_or_initialize_by(id: param[:id])
  category.update!(param)
end
