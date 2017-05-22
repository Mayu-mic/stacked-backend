# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Create System User
system_user = User.new(
    name: 'system',
    nickname: 'system',
    image: '',
    email: 'system@example.com',
    password: 'P?CAHLk7Xg@j/yEnvUp&',
    uid: 'system'
)
system_user.save!


# Create Default List
list = List.new(
    name: 'default',
    order: 0,
    created_by_id: 1,
    is_system: true
)
list.save!


# Initial Stacks
Stack.create([
    {
        list: list,
        title: "Stacked へようこそ！",
        created_by_id: 1,
    },
    {
        list: list,
        title: "Stackは自由に追加できます。",
        created_by_id: 1,
    },
    {
        list: list,
        title: "❤を押すと、並び順が上に表示されます。",
        created_by_id: 1,
    },
    {
        list: list,
        title: "コメントも自由に追加できます。",
        created_by_id: 1,
    },
])

Comment.create([
    {
        stack: Stack.all.last,
        body: "コメントです。",
        created_by_id: 1,
    }
])
