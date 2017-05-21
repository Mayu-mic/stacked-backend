# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

system_user = User.new(
    name: 'system',
    nickname: 'system',
    image: '',
    email: 'system@stacked.com',
    password: 'system-stacked',
    uid: 'system'
)
system_user.save!

list = List.new(
    name: 'default',
    order: 0,
    created_by_id: 1, # system user
    is_system: true
)
list.save!

Stack.create([
    {
        list: list,
        title: "Stacked へようこそ！",
        created_by_id: 1,
    },
    {
        list: list,
        title: "タスクは自由に追加できます。",
        created_by_id: 1,
    },
    {
        list: list,
        title: "それなを押すと、上に表示されます。",
        created_by_id: 1,
    },
])

Comment.create([
    {
        stack: Stack.all.first,
        body: "コメントも自由に追加できます。",
        created_by_id: 1,
    }
])
